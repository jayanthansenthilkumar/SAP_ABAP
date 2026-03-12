using StudentService as service from '../../srv/student-service';

// ═══════════════════════════════════════════════════════════════
// ─── 1. STUDENTS ──────────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Students with @(
    UI.HeaderInfo: {
        TypeName      : 'Student',
        TypeNamePlural: 'Students',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: regno }
    },
    UI.SelectionFields: [ name, regno, status, department_ID ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name,           Label: 'Student Name',        Position: 10 },
        { $Type: 'UI.DataField', Value: regno,           Label: 'Registration Number', Position: 20 },
        { $Type: 'UI.DataField', Value: email,           Label: 'Email',               Position: 30 },
        { $Type: 'UI.DataField', Value: phone,           Label: 'Phone Number',        Position: 40 },
        { $Type: 'UI.DataField', Value: department.name, Label: 'Department',          Position: 50 },
        { $Type: 'UI.DataField', Value: status,          Label: 'Status',              Position: 60, Criticality: statusCriticality }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'StudentInfo',     Label: 'Student Information', Target: '@UI.FieldGroup#StudentInfo'   },
        { $Type: 'UI.ReferenceFacet', ID: 'DepartmentInfo',  Label: 'Department',          Target: '@UI.FieldGroup#DeptInfo'      },
        { $Type: 'UI.ReferenceFacet', ID: 'AddressFacet',    Label: 'Addresses',           Target: 'addresses/@UI.LineItem'       },
        { $Type: 'UI.ReferenceFacet', ID: 'EnrollmentFacet', Label: 'Course Enrollments',  Target: 'enrollments/@UI.LineItem'     },
        { $Type: 'UI.ReferenceFacet', ID: 'ExamResultFacet', Label: 'Exam Results',        Target: 'examResults/@UI.LineItem'     },
        { $Type: 'UI.ReferenceFacet', ID: 'AdminInfo',       Label: 'Administrative Data', Target: '@UI.FieldGroup#AdminData'     }
    ],
    UI.FieldGroup #StudentInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: name,        Label: 'Student Name'        },
            { $Type: 'UI.DataField', Value: regno,        Label: 'Registration Number' },
            { $Type: 'UI.DataField', Value: email,        Label: 'Email'               },
            { $Type: 'UI.DataField', Value: phone,        Label: 'Phone Number'        },
            { $Type: 'UI.DataField', Value: dateOfBirth,  Label: 'Date of Birth'       },
            { $Type: 'UI.DataField', Value: status,       Label: 'Status'              }
        ]
    },
    UI.FieldGroup #DeptInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: department_ID,    Label: 'Department'      },
            { $Type: 'UI.DataField', Value: department.code,  Label: 'Department Code' }
        ]
    },
    UI.FieldGroup #AdminData: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By'      },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At'      },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By' },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At' }
        ]
    }
);

annotate service.Students with {
    status @Common.Text: statusText @Common.TextArrangement: #TextOnly;
};

annotate service.Students with {
    name        @title: 'Student Name'        @Common.FieldControl: #Mandatory;
    regno       @title: 'Registration Number' @Common.FieldControl: #Mandatory;
    email       @title: 'Email';
    phone       @title: 'Phone Number';
    dateOfBirth @title: 'Date of Birth';
    status      @title: 'Status';
    department  @title: 'Department'
        @Common.ValueList: {
            CollectionPath: 'Departments',
            Label: 'Departments',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',         LocalDataProperty: department_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly',   ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly',   ValueListProperty: 'code' }
            ]
        };
};


// ═══════════════════════════════════════════════════════════════
// ─── 2. ADDRESSES (child of Student) ──────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Addresses with @(
    UI.HeaderInfo: {
        TypeName      : 'Address',
        TypeNamePlural: 'Addresses',
        Title         : { $Type: 'UI.DataField', Value: city },
        Description   : { $Type: 'UI.DataField', Value: addressType }
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: addressType, Label: 'Type',        Position: 10 },
        { $Type: 'UI.DataField', Value: street,      Label: 'Street',      Position: 20 },
        { $Type: 'UI.DataField', Value: city,        Label: 'City',        Position: 30 },
        { $Type: 'UI.DataField', Value: state,       Label: 'State',       Position: 40 },
        { $Type: 'UI.DataField', Value: postalCode,  Label: 'Postal Code', Position: 50 },
        { $Type: 'UI.DataField', Value: country,     Label: 'Country',     Position: 60 }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'AddressDetails', Label: 'Address Details', Target: '@UI.FieldGroup#AddressDetails' }
    ],
    UI.FieldGroup #AddressDetails: {
        Data: [
            { $Type: 'UI.DataField', Value: addressType, Label: 'Address Type' },
            { $Type: 'UI.DataField', Value: street,      Label: 'Street'       },
            { $Type: 'UI.DataField', Value: city,        Label: 'City'         },
            { $Type: 'UI.DataField', Value: state,       Label: 'State'        },
            { $Type: 'UI.DataField', Value: postalCode,  Label: 'Postal Code'  },
            { $Type: 'UI.DataField', Value: country,     Label: 'Country'      }
        ]
    }
);

annotate service.Addresses with {
    addressType @title: 'Address Type';
    street      @title: 'Street';
    city        @title: 'City';
    state       @title: 'State';
    postalCode  @title: 'Postal Code';
    country     @title: 'Country';
};


// ═══════════════════════════════════════════════════════════════
// ─── 3. ENROLLMENTS (child of Student) ────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Enrollments with @(
    UI.HeaderInfo: {
        TypeName      : 'Enrollment',
        TypeNamePlural: 'Enrollments',
        Title         : { $Type: 'UI.DataField', Value: course.title },
        Description   : { $Type: 'UI.DataField', Value: enrollmentDate }
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: course_ID,       Label: 'Course',          Position: 10 },
        { $Type: 'UI.DataField', Value: course.title,    Label: 'Course Title',    Position: 20 },
        { $Type: 'UI.DataField', Value: semester_ID,     Label: 'Semester',        Position: 25 },
        { $Type: 'UI.DataField', Value: enrollmentDate,  Label: 'Enrollment Date', Position: 30 },
        { $Type: 'UI.DataField', Value: grade,           Label: 'Grade',           Position: 40 },
        { $Type: 'UI.DataField', Value: status,          Label: 'Status',          Position: 50, Criticality: enrollStatusCriticality }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'EnrollmentDetails', Label: 'Enrollment Details', Target: '@UI.FieldGroup#EnrollmentDetails' }
    ],
    UI.FieldGroup #EnrollmentDetails: {
        Data: [
            { $Type: 'UI.DataField', Value: course_ID,      Label: 'Course'          },
            { $Type: 'UI.DataField', Value: semester_ID,     Label: 'Semester'        },
            { $Type: 'UI.DataField', Value: enrollmentDate,  Label: 'Enrollment Date' },
            { $Type: 'UI.DataField', Value: grade,           Label: 'Grade'           },
            { $Type: 'UI.DataField', Value: status,          Label: 'Status'          }
        ]
    }
);

annotate service.Enrollments with {
    course         @title: 'Course'
        @Common.ValueList: {
            CollectionPath: 'Courses',
            Label: 'Courses',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: course_ID, ValueListProperty: 'ID'        },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'title'     },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'courseCode' }
            ]
        };
    semester       @title: 'Semester'
        @Common.ValueList: {
            CollectionPath: 'Semesters',
            Label: 'Semesters',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: semester_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'code' }
            ]
        };
    enrollmentDate @title: 'Enrollment Date' @Common.FieldControl: #Mandatory;
    grade          @title: 'Grade';
    status         @title: 'Enrollment Status';
};


// ═══════════════════════════════════════════════════════════════
// ─── 4. COURSES ───────────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Courses with @(
    UI.HeaderInfo: {
        TypeName      : 'Course',
        TypeNamePlural: 'Courses',
        Title         : { $Type: 'UI.DataField', Value: title },
        Description   : { $Type: 'UI.DataField', Value: courseCode }
    },
    UI.SelectionFields: [ title, courseCode, department_ID, professor_ID ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: courseCode,       Label: 'Course Code',  Position: 10 },
        { $Type: 'UI.DataField', Value: title,            Label: 'Title',        Position: 20 },
        { $Type: 'UI.DataField', Value: credits,          Label: 'Credits',      Position: 30 },
        { $Type: 'UI.DataField', Value: department.name,  Label: 'Department',   Position: 40 },
        { $Type: 'UI.DataField', Value: professor.name,   Label: 'Professor',    Position: 50 },
        { $Type: 'UI.DataField', Value: maxStudents,      Label: 'Max Students', Position: 60 }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'CourseInfo',        Label: 'Course Details',    Target: '@UI.FieldGroup#CourseInfo'      },
        { $Type: 'UI.ReferenceFacet', ID: 'CourseEnrollments', Label: 'Enrolled Students', Target: 'enrollments/@UI.LineItem'       },
        { $Type: 'UI.ReferenceFacet', ID: 'CourseExams',       Label: 'Exam Schedules',    Target: 'examSchedules/@UI.LineItem'     },
        { $Type: 'UI.ReferenceFacet', ID: 'CourseAdmin',       Label: 'Administrative',    Target: '@UI.FieldGroup#CourseAdmin'     }
    ],
    UI.FieldGroup #CourseInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: courseCode,     Label: 'Course Code'  },
            { $Type: 'UI.DataField', Value: title,          Label: 'Title'        },
            { $Type: 'UI.DataField', Value: credits,        Label: 'Credits'      },
            { $Type: 'UI.DataField', Value: maxStudents,    Label: 'Max Students' },
            { $Type: 'UI.DataField', Value: department_ID,  Label: 'Department'   },
            { $Type: 'UI.DataField', Value: professor_ID,   Label: 'Professor'    },
            { $Type: 'UI.DataField', Value: description,    Label: 'Description'  }
        ]
    },
    UI.FieldGroup #CourseAdmin: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By'      },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At'      },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By' },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At' }
        ]
    }
);

annotate service.Courses with {
    courseCode   @title: 'Course Code'  @Common.FieldControl: #Mandatory;
    title        @title: 'Course Title' @Common.FieldControl: #Mandatory;
    credits      @title: 'Credits'      @Common.FieldControl: #Mandatory;
    maxStudents  @title: 'Max Students';
    description  @title: 'Description';
    department   @title: 'Department'
        @Common.ValueList: {
            CollectionPath: 'Departments',
            Label: 'Departments',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: department_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'code' }
            ]
        };
    professor    @title: 'Professor'
        @Common.ValueList: {
            CollectionPath: 'Professors',
            Label: 'Professors',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: professor_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'       },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'employeeId' }
            ]
        };
};


// ═══════════════════════════════════════════════════════════════
// ─── 5. DEPARTMENTS ──────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Departments with @(
    UI.HeaderInfo: {
        TypeName      : 'Department',
        TypeNamePlural: 'Departments',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: code }
    },
    UI.SelectionFields: [ name, code ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: code,        Label: 'Code',         Position: 10 },
        { $Type: 'UI.DataField', Value: name,        Label: 'Name',         Position: 20 },
        { $Type: 'UI.DataField', Value: headOfDept,  Label: 'Head of Dept', Position: 30 },
        { $Type: 'UI.DataField', Value: description, Label: 'Description',  Position: 40 }
    ]
);

annotate service.Departments with {
    code        @title: 'Department Code';
    name        @title: 'Department Name';
    headOfDept  @title: 'Head of Department';
    description @title: 'Description';
};


// ═══════════════════════════════════════════════════════════════
// ─── 6. PROFESSORS ───────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Professors with @(
    UI.HeaderInfo: {
        TypeName      : 'Professor',
        TypeNamePlural: 'Professors',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: employeeId }
    },
    UI.SelectionFields: [ name, employeeId, department_ID ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name,             Label: 'Name',           Position: 10 },
        { $Type: 'UI.DataField', Value: employeeId,       Label: 'Employee ID',    Position: 20 },
        { $Type: 'UI.DataField', Value: email,            Label: 'Email',          Position: 30 },
        { $Type: 'UI.DataField', Value: phone,            Label: 'Phone',          Position: 40 },
        { $Type: 'UI.DataField', Value: specialization,   Label: 'Specialization', Position: 50 },
        { $Type: 'UI.DataField', Value: department.name,  Label: 'Department',     Position: 60 }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'ProfInfo',    Label: 'Professor Details', Target: '@UI.FieldGroup#ProfInfo'    },
        { $Type: 'UI.ReferenceFacet', ID: 'ProfCourses', Label: 'Assigned Courses',  Target: 'courses/@UI.LineItem'       },
        { $Type: 'UI.ReferenceFacet', ID: 'ProfAdmin',   Label: 'Administrative',    Target: '@UI.FieldGroup#ProfAdmin'   }
    ],
    UI.FieldGroup #ProfInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: name,           Label: 'Full Name'       },
            { $Type: 'UI.DataField', Value: employeeId,     Label: 'Employee ID'     },
            { $Type: 'UI.DataField', Value: email,          Label: 'Email'           },
            { $Type: 'UI.DataField', Value: phone,          Label: 'Phone'           },
            { $Type: 'UI.DataField', Value: specialization, Label: 'Specialization'  },
            { $Type: 'UI.DataField', Value: department_ID,  Label: 'Department'      }
        ]
    },
    UI.FieldGroup #ProfAdmin: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By'      },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At'      },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By' },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At' }
        ]
    }
);

annotate service.Professors with {
    name           @title: 'Professor Name' @Common.FieldControl: #Mandatory;
    employeeId     @title: 'Employee ID'    @Common.FieldControl: #Mandatory;
    email          @title: 'Email';
    phone          @title: 'Phone';
    specialization @title: 'Specialization';
    department     @title: 'Department'
        @Common.ValueList: {
            CollectionPath: 'Departments',
            Label: 'Departments',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: department_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'code' }
            ]
        };
};


// ═══════════════════════════════════════════════════════════════
// ─── 7. SEMESTERS ────────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Semesters with @(
    UI.HeaderInfo: {
        TypeName      : 'Semester',
        TypeNamePlural: 'Semesters',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: code }
    },
    UI.SelectionFields: [ name, code, isCurrent ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: code,       Label: 'Code',       Position: 10 },
        { $Type: 'UI.DataField', Value: name,       Label: 'Name',       Position: 20 },
        { $Type: 'UI.DataField', Value: startDate,  Label: 'Start Date', Position: 30 },
        { $Type: 'UI.DataField', Value: endDate,    Label: 'End Date',   Position: 40 },
        { $Type: 'UI.DataField', Value: isCurrent,  Label: 'Current?',   Position: 50, Criticality: currentCriticality }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'SemesterInfo',  Label: 'Semester Details',  Target: '@UI.FieldGroup#SemesterInfo'  },
        { $Type: 'UI.ReferenceFacet', ID: 'SemesterExams', Label: 'Exam Schedules',    Target: 'examSchedules/@UI.LineItem'   }
    ],
    UI.FieldGroup #SemesterInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: code,       Label: 'Semester Code' },
            { $Type: 'UI.DataField', Value: name,       Label: 'Semester Name' },
            { $Type: 'UI.DataField', Value: startDate,  Label: 'Start Date'    },
            { $Type: 'UI.DataField', Value: endDate,    Label: 'End Date'      },
            { $Type: 'UI.DataField', Value: isCurrent,  Label: 'Current?'      }
        ]
    }
);

annotate service.Semesters with {
    code      @title: 'Semester Code' @Common.FieldControl: #Mandatory;
    name      @title: 'Semester Name' @Common.FieldControl: #Mandatory;
    startDate @title: 'Start Date'    @Common.FieldControl: #Mandatory;
    endDate   @title: 'End Date'      @Common.FieldControl: #Mandatory;
    isCurrent @title: 'Is Current';
};


// ═══════════════════════════════════════════════════════════════
// ─── 8. EXAM SCHEDULES ──────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.ExamSchedules with @(
    UI.HeaderInfo: {
        TypeName      : 'Exam Schedule',
        TypeNamePlural: 'Exam Schedules',
        Title         : { $Type: 'UI.DataField', Value: course.title },
        Description   : { $Type: 'UI.DataField', Value: examType }
    },
    UI.SelectionFields: [ course_ID, semester_ID, examType, examDate ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: course.title,    Label: 'Course',        Position: 10 },
        { $Type: 'UI.DataField', Value: semester.name,   Label: 'Semester',      Position: 20 },
        { $Type: 'UI.DataField', Value: examType,        Label: 'Exam Type',     Position: 30, Criticality: examTypeCriticality },
        { $Type: 'UI.DataField', Value: examDate,        Label: 'Date',          Position: 40 },
        { $Type: 'UI.DataField', Value: startTime,       Label: 'Start Time',    Position: 50 },
        { $Type: 'UI.DataField', Value: endTime,         Label: 'End Time',      Position: 60 },
        { $Type: 'UI.DataField', Value: venue,           Label: 'Venue',         Position: 70 },
        { $Type: 'UI.DataField', Value: maxMarks,        Label: 'Max Marks',     Position: 80 }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'ExamInfo',    Label: 'Exam Details',  Target: '@UI.FieldGroup#ExamInfo'    },
        { $Type: 'UI.ReferenceFacet', ID: 'ExamResults', Label: 'Results',       Target: 'results/@UI.LineItem'       },
        { $Type: 'UI.ReferenceFacet', ID: 'ExamAdmin',   Label: 'Administrative', Target: '@UI.FieldGroup#ExamAdmin' }
    ],
    UI.FieldGroup #ExamInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: course_ID,    Label: 'Course'        },
            { $Type: 'UI.DataField', Value: semester_ID,   Label: 'Semester'      },
            { $Type: 'UI.DataField', Value: examType,      Label: 'Exam Type'     },
            { $Type: 'UI.DataField', Value: examDate,      Label: 'Exam Date'     },
            { $Type: 'UI.DataField', Value: startTime,     Label: 'Start Time'    },
            { $Type: 'UI.DataField', Value: endTime,       Label: 'End Time'      },
            { $Type: 'UI.DataField', Value: venue,         Label: 'Venue'         },
            { $Type: 'UI.DataField', Value: maxMarks,      Label: 'Max Marks'     },
            { $Type: 'UI.DataField', Value: passingMarks,  Label: 'Passing Marks' },
            { $Type: 'UI.DataField', Value: instructions,  Label: 'Instructions'  }
        ]
    },
    UI.FieldGroup #ExamAdmin: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By'      },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At'      },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By' },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At' }
        ]
    }
);

annotate service.ExamSchedules with {
    course       @title: 'Course'
        @Common.ValueList: {
            CollectionPath: 'Courses',
            Label: 'Courses',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: course_ID, ValueListProperty: 'ID'        },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'title'     },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'courseCode' }
            ]
        };
    semester     @title: 'Semester'
        @Common.ValueList: {
            CollectionPath: 'Semesters',
            Label: 'Semesters',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: semester_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'code' }
            ]
        };
    examType     @title: 'Exam Type'     @Common.FieldControl: #Mandatory;
    examDate     @title: 'Exam Date'     @Common.FieldControl: #Mandatory;
    startTime    @title: 'Start Time'    @Common.FieldControl: #Mandatory;
    endTime      @title: 'End Time'      @Common.FieldControl: #Mandatory;
    venue        @title: 'Venue';
    maxMarks     @title: 'Max Marks';
    passingMarks @title: 'Passing Marks';
    instructions @title: 'Instructions';
};


// ═══════════════════════════════════════════════════════════════
// ─── 9. EXAM RESULTS (child of Student) ──────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.ExamResults with @(
    UI.HeaderInfo: {
        TypeName      : 'Exam Result',
        TypeNamePlural: 'Exam Results',
        Title         : { $Type: 'UI.DataField', Value: examSchedule.course.title },
        Description   : { $Type: 'UI.DataField', Value: grade }
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: examSchedule_ID,            Label: 'Exam',            Position: 10 },
        { $Type: 'UI.DataField', Value: examSchedule.examType,      Label: 'Exam Type',       Position: 20 },
        { $Type: 'UI.DataField', Value: examSchedule.examDate,      Label: 'Exam Date',       Position: 30 },
        { $Type: 'UI.DataField', Value: marksObtained,              Label: 'Marks Obtained',  Position: 40 },
        { $Type: 'UI.DataField', Value: grade,                      Label: 'Grade',           Position: 50 },
        { $Type: 'UI.DataField', Value: isPassed,                   Label: 'Passed?',         Position: 60, Criticality: passedCriticality },
        { $Type: 'UI.DataField', Value: resultStatus,               Label: 'Status',          Position: 70, Criticality: resultStatusCriticality }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'ResultDetails', Label: 'Result Details', Target: '@UI.FieldGroup#ResultDetails' }
    ],
    UI.FieldGroup #ResultDetails: {
        Data: [
            { $Type: 'UI.DataField', Value: examSchedule_ID, Label: 'Exam Schedule'  },
            { $Type: 'UI.DataField', Value: marksObtained,   Label: 'Marks Obtained' },
            { $Type: 'UI.DataField', Value: grade,           Label: 'Grade'          },
            { $Type: 'UI.DataField', Value: isPassed,        Label: 'Passed?'        },
            { $Type: 'UI.DataField', Value: resultStatus,    Label: 'Result Status'  },
            { $Type: 'UI.DataField', Value: remarks,         Label: 'Remarks'        },
            { $Type: 'UI.DataField', Value: publishedAt,     Label: 'Published At'   },
            { $Type: 'UI.DataField', Value: publishedBy,     Label: 'Published By'   }
        ]
    }
);

annotate service.ExamResults with {
    resultStatus @Common.Text: resultStatusText @Common.TextArrangement: #TextOnly;
};

annotate service.ExamResults with {
    examSchedule  @title: 'Exam Schedule'
        @Common.ValueList: {
            CollectionPath: 'ExamSchedules',
            Label: 'Exam Schedules',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: examSchedule_ID, ValueListProperty: 'ID' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'examType'  },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'examDate'  }
            ]
        };
    marksObtained @title: 'Marks Obtained';
    grade         @title: 'Grade';
    isPassed      @title: 'Passed';
    resultStatus  @title: 'Result Status';
    remarks       @title: 'Remarks';
    publishedAt   @title: 'Published At';
    publishedBy   @title: 'Published By';
};


// ═══════════════════════════════════════════════════════════════
// ─── 10. USERS (Login Portal) ────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Users with @(
    UI.HeaderInfo: {
        TypeName      : 'User',
        TypeNamePlural: 'Users',
        Title         : { $Type: 'UI.DataField', Value: displayName },
        Description   : { $Type: 'UI.DataField', Value: role }
    },
    UI.SelectionFields: [ username, role, isActive ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: username,    Label: 'Username',     Position: 10 },
        { $Type: 'UI.DataField', Value: displayName, Label: 'Display Name', Position: 20 },
        { $Type: 'UI.DataField', Value: email,       Label: 'Email',        Position: 30 },
        { $Type: 'UI.DataField', Value: role,        Label: 'Role',         Position: 40, Criticality: roleCriticality },
        { $Type: 'UI.DataField', Value: isActive,    Label: 'Active',       Position: 50, Criticality: activeCriticality },
        { $Type: 'UI.DataField', Value: lastLoginAt, Label: 'Last Login',   Position: 60 }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'UserInfo',     Label: 'User Details',  Target: '@UI.FieldGroup#UserInfo'     },
        { $Type: 'UI.ReferenceFacet', ID: 'UserLinked',   Label: 'Linked Profile', Target: '@UI.FieldGroup#UserLinked' },
        { $Type: 'UI.ReferenceFacet', ID: 'UserAdmin',    Label: 'Administrative', Target: '@UI.FieldGroup#UserAdmin'   }
    ],
    UI.FieldGroup #UserInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: username,    Label: 'Username'     },
            { $Type: 'UI.DataField', Value: displayName, Label: 'Display Name' },
            { $Type: 'UI.DataField', Value: email,       Label: 'Email'        },
            { $Type: 'UI.DataField', Value: role,        Label: 'Role'         },
            { $Type: 'UI.DataField', Value: isActive,    Label: 'Active'       },
            { $Type: 'UI.DataField', Value: lastLoginAt, Label: 'Last Login'   }
        ]
    },
    UI.FieldGroup #UserLinked: {
        Data: [
            { $Type: 'UI.DataField', Value: student_ID,   Label: 'Linked Student'   },
            { $Type: 'UI.DataField', Value: professor_ID,  Label: 'Linked Professor' }
        ]
    },
    UI.FieldGroup #UserAdmin: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By'      },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At'      },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By' },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At' }
        ]
    }
);

annotate service.Users with {
    username    @title: 'Username'     @Common.FieldControl: #Mandatory;
    displayName @title: 'Display Name';
    email       @title: 'Email'        @Common.FieldControl: #Mandatory;
    role        @title: 'Role'         @Common.FieldControl: #Mandatory;
    isActive    @title: 'Active';
    lastLoginAt @title: 'Last Login';
    student     @title: 'Linked Student'
        @Common.ValueList: {
            CollectionPath: 'Students',
            Label: 'Students',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: student_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'  },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'regno' }
            ]
        };
    professor   @title: 'Linked Professor'
        @Common.ValueList: {
            CollectionPath: 'Professors',
            Label: 'Professors',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: professor_ID, ValueListProperty: 'ID'         },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'       },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'employeeId' }
            ]
        };
};


// ═══════════════════════════════════════════════════════════════
// ─── 11. ATTENDANCE ──────────────────────────────────────────
// ═══════════════════════════════════════════════════════════════

annotate service.Attendance with @(
    UI.HeaderInfo: {
        TypeName      : 'Attendance Record',
        TypeNamePlural: 'Attendance',
        Title         : { $Type: 'UI.DataField', Value: student.name },
        Description   : { $Type: 'UI.DataField', Value: attendanceDate }
    },
    UI.SelectionFields: [ student_ID, course_ID, semester_ID, status, attendanceDate ],
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: student.name,    Label: 'Student',   Position: 10 },
        { $Type: 'UI.DataField', Value: student.regno,   Label: 'Reg No',    Position: 20 },
        { $Type: 'UI.DataField', Value: course.title,    Label: 'Course',    Position: 30 },
        { $Type: 'UI.DataField', Value: semester.name,   Label: 'Semester',  Position: 40 },
        { $Type: 'UI.DataField', Value: attendanceDate,  Label: 'Date',      Position: 50 },
        { $Type: 'UI.DataField', Value: status,          Label: 'Status',    Position: 60, Criticality: attendanceCriticality },
        { $Type: 'UI.DataField', Value: remarks,         Label: 'Remarks',   Position: 70 }
    ],
    UI.Facets: [
        { $Type: 'UI.ReferenceFacet', ID: 'AttendanceInfo', Label: 'Attendance Details', Target: '@UI.FieldGroup#AttendanceInfo' }
    ],
    UI.FieldGroup #AttendanceInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: student_ID,     Label: 'Student'   },
            { $Type: 'UI.DataField', Value: course_ID,       Label: 'Course'    },
            { $Type: 'UI.DataField', Value: semester_ID,     Label: 'Semester'  },
            { $Type: 'UI.DataField', Value: attendanceDate,  Label: 'Date'      },
            { $Type: 'UI.DataField', Value: status,          Label: 'Status'    },
            { $Type: 'UI.DataField', Value: remarks,         Label: 'Remarks'   }
        ]
    }
);

annotate service.Attendance with {
    status @Common.Text: attendanceStatusText @Common.TextArrangement: #TextOnly;
};

annotate service.Attendance with {
    student        @title: 'Student'
        @Common.ValueList: {
            CollectionPath: 'Students',
            Label: 'Students',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: student_ID, ValueListProperty: 'ID'    },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'  },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'regno' }
            ]
        };
    course         @title: 'Course'
        @Common.ValueList: {
            CollectionPath: 'Courses',
            Label: 'Courses',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: course_ID, ValueListProperty: 'ID'        },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'title'     },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'courseCode' }
            ]
        };
    semester       @title: 'Semester'
        @Common.ValueList: {
            CollectionPath: 'Semesters',
            Label: 'Semesters',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',       LocalDataProperty: semester_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'code' }
            ]
        };
    attendanceDate @title: 'Date'   @Common.FieldControl: #Mandatory;
    status         @title: 'Status' @Common.FieldControl: #Mandatory;
    remarks        @title: 'Remarks';
};
