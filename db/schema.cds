namespace student.management;

using { cuid, managed, Currency, Country, sap.common.CodeList } from '@sap/cds/common';

// ── Status code list ────────────────────────────────────────
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

// ── Department ──────────────────────────────────────────────
entity Departments : cuid, managed {
    code        : String(10)  @mandatory;
    name        : String(100) @mandatory;
    description : String(500);
    headOfDept  : String(100);
    students    : Association to many Students on students.department = $self;
    courses     : Association to many Courses  on courses.department  = $self;
}

// ── Course ──────────────────────────────────────────────────
entity Courses : cuid, managed {
    courseCode   : String(15)  @mandatory;
    title        : String(150) @mandatory;
    credits      : Integer     @mandatory;
    description  : String(500);
    department   : Association to Departments;
    enrollments  : Association to many Enrollments on enrollments.course = $self;
}

// ── Student (enhanced) ──────────────────────────────────────
entity Students : cuid, managed {
    name         : String(50)  @mandatory;
    regno        : String(20)  @mandatory;
    email        : String(100);
    phone        : String(15);
    dateOfBirth  : Date;
    status       : StudentStatus default 'A';
    department   : Association to Departments;
    addresses    : Composition of many Addresses on addresses.student = $self;
    enrollments  : Composition of many Enrollments on enrollments.student = $self;
}

// ── Address (child of Student) ──────────────────────────────
entity Addresses : cuid, managed {
    student    : Association to Students;
    addressType: String(10) default 'HOME';  // HOME, MAIL, TEMP
    street     : String(200);
    city       : String(100);
    state      : String(100);
    postalCode : String(20);
    country    : String(50);
}

// ── Enrollment (child of Student, links to Course) ──────────
entity Enrollments : cuid, managed {
    student        : Association to Students;
    course         : Association to Courses;
    enrollmentDate : Date    @mandatory;
    grade          : String(2);         // A, B+, B, C+, C, D, F
    status         : EnrollmentStatus default 'E';
}
