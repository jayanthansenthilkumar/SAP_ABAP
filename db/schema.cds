namespace student.management;

using { cuid, managed, Currency, Country, sap.common.CodeList } from '@sap/cds/common';

// ══════════════════════════════════════════════════════════════
// ── Enum Types ───────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════

type StudentStatus : String(1) enum {
    Active    = 'A';
    Inactive  = 'I';
    Graduated = 'G';
};

type EnrollmentStatus : String(1) enum {
    Enrolled  = 'E';
    Completed = 'C';
    Dropped   = 'D';
};

type ExamType : String(10) enum {
    Midterm   = 'MID';
    Final     = 'FINAL';
    Quiz      = 'QUIZ';
    Practical = 'PRAC';
    Internal  = 'INT';
};

type ResultStatus : String(1) enum {
    Draft     = 'D';
    Published = 'P';
    Withheld  = 'W';
};

type UserRole : String(10) enum {
    Admin     = 'ADMIN';
    Professor = 'PROF';
    Student   = 'STUD';
};

type AttendanceStatus : String(1) enum {
    Present = 'P';
    Absent  = 'A';
    Late    = 'L';
    Excused = 'E';
};

// ══════════════════════════════════════════════════════════════
// ── 1. Departments ───────────────────────────────────────────
// ══════════════════════════════════════════════════════════════
entity Departments : cuid, managed {
    code        : String(10)  @mandatory;
    name        : String(100) @mandatory;
    description : String(500);
    headOfDept  : String(100);
    students    : Association to many Students   on students.department  = $self;
    courses     : Association to many Courses    on courses.department   = $self;
    professors  : Association to many Professors on professors.department = $self;
}

// ══════════════════════════════════════════════════════════════
// ── 2. Professors ────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════
entity Professors : cuid, managed {
    name         : String(100) @mandatory;
    employeeId   : String(20)  @mandatory;
    email        : String(100);
    phone        : String(15);
    specialization : String(200);
    department   : Association to Departments;
    courses      : Association to many Courses on courses.professor = $self;
}

// ══════════════════════════════════════════════════════════════
// ── 3. Semesters ─────────────────────────────────────────────
// ══════════════════════════════════════════════════════════════
entity Semesters : cuid, managed {
    code         : String(15)  @mandatory;   // e.g. FALL-2025
    name         : String(50)  @mandatory;   // e.g. Fall Semester 2025
    startDate    : Date        @mandatory;
    endDate      : Date        @mandatory;
    isCurrent    : Boolean default false;
    examSchedules : Association to many ExamSchedules on examSchedules.semester = $self;
}

// ══════════════════════════════════════════════════════════════
// ── 4. Courses (enhanced with professor & semester links) ────
// ══════════════════════════════════════════════════════════════
entity Courses : cuid, managed {
    courseCode    : String(15)  @mandatory;
    title         : String(150) @mandatory;
    credits       : Integer     @mandatory;
    description   : String(500);
    maxStudents   : Integer default 60;
    department    : Association to Departments;
    professor     : Association to Professors;
    enrollments   : Association to many Enrollments   on enrollments.course   = $self;
    examSchedules : Association to many ExamSchedules on examSchedules.course = $self;
    attendance    : Association to many Attendance     on attendance.course    = $self;
}

// ══════════════════════════════════════════════════════════════
// ── 5. Students (enhanced) ───────────────────────────────────
// ══════════════════════════════════════════════════════════════
entity Students : cuid, managed {
    name         : String(50)  @mandatory;
    regno        : String(20)  @mandatory;
    email        : String(100);
    phone        : String(15);
    dateOfBirth  : Date;
    status       : StudentStatus default 'A';
    department   : Association to Departments;
    addresses    : Composition of many Addresses    on addresses.student    = $self;
    enrollments  : Composition of many Enrollments  on enrollments.student  = $self;
    examResults  : Composition of many ExamResults  on examResults.student  = $self;
    attendance   : Association to many Attendance    on attendance.student   = $self;
}

// ══════════════════════════════════════════════════════════════
// ── 6. Addresses (child of Student) ──────────────────────────
// ══════════════════════════════════════════════════════════════
entity Addresses : cuid, managed {
    student     : Association to Students;
    addressType : String(10) default 'HOME';
    street      : String(200);
    city        : String(100);
    state       : String(100);
    postalCode  : String(20);
    country     : String(50);
}

// ══════════════════════════════════════════════════════════════
// ── 7. Enrollments (child of Student, links to Course) ───────
// ══════════════════════════════════════════════════════════════
entity Enrollments : cuid, managed {
    student        : Association to Students;
    course         : Association to Courses;
    semester       : Association to Semesters;
    enrollmentDate : Date    @mandatory;
    grade          : String(2);
    status         : EnrollmentStatus default 'E';
}

// ══════════════════════════════════════════════════════════════
// ── 8. ExamSchedules ─────────────────────────────────────────
//    Joins: Course + Semester + Professor (via Course)
// ══════════════════════════════════════════════════════════════
entity ExamSchedules : cuid, managed {
    course       : Association to Courses;
    semester     : Association to Semesters;
    examType     : ExamType  @mandatory;
    examDate     : Date      @mandatory;
    startTime    : Time      @mandatory;
    endTime      : Time      @mandatory;
    venue        : String(100);
    maxMarks     : Integer default 100;
    passingMarks : Integer default 40;
    instructions : String(500);
    results      : Association to many ExamResults on results.examSchedule = $self;
}

// ══════════════════════════════════════════════════════════════
// ── 9. ExamResults (child of Student, links to ExamSchedule) ─
//    Joins: Student + ExamSchedule + Course + Semester
// ══════════════════════════════════════════════════════════════
entity ExamResults : cuid, managed {
    student       : Association to Students;
    examSchedule  : Association to ExamSchedules;
    marksObtained : Integer;
    grade         : String(2);
    isPassed      : Boolean default false;
    remarks       : String(200);
    resultStatus  : ResultStatus default 'D';
    publishedAt   : Timestamp;
    publishedBy   : String(100);
}

// ══════════════════════════════════════════════════════════════
// ── 10. Users (Login Portal) ─────────────────────────────────
// ══════════════════════════════════════════════════════════════
entity Users : cuid, managed {
    username     : String(50)  @mandatory;
    email        : String(100) @mandatory;
    role         : UserRole    @mandatory;
    displayName  : String(100);
    isActive     : Boolean default true;
    lastLoginAt  : Timestamp;
    student      : Association to Students;
    professor    : Association to Professors;
}

// ══════════════════════════════════════════════════════════════
// ── 11. Attendance ───────────────────────────────────────────
//    Joins: Student + Course + Semester
// ══════════════════════════════════════════════════════════════
entity Attendance : cuid, managed {
    student      : Association to Students;
    course       : Association to Courses;
    semester     : Association to Semesters;
    attendanceDate : Date @mandatory;
    status       : AttendanceStatus default 'P';
    remarks      : String(200);
}
