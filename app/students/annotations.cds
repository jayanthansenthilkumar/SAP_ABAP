using StudentService as service from '../../srv/student-service';

////////////////////////////////////////////////////////////
// ─── STUDENTS ──────────────────────────────────────────
////////////////////////////////////////////////////////////

annotate service.Students with @(
    UI.HeaderInfo: {
        TypeName      : 'Student',
        TypeNamePlural: 'Students',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: regno }
    }
);

annotate service.Students with @(
    UI.SelectionFields: [
        name,
        regno,
        status,
        department_ID
    ]
);

annotate service.Students with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name,          Label: 'Student Name',         Position: 10 },
        { $Type: 'UI.DataField', Value: regno,          Label: 'Registration Number',  Position: 20 },
        { $Type: 'UI.DataField', Value: email,          Label: 'Email',                Position: 30 },
        { $Type: 'UI.DataField', Value: phone,          Label: 'Phone Number',         Position: 40 },
        { $Type: 'UI.DataField', Value: department.name, Label: 'Department',           Position: 50 },
        {
            $Type: 'UI.DataField', Value: status, Label: 'Status', Position: 60,
            Criticality: statusCriticality
        },
        { $Type: 'UI.DataField', Value: dateOfBirth,    Label: 'Date of Birth',        Position: 70 }
    ]
);

// Virtual element for status criticality coloring
annotate service.Students with {
    status @Common.Text: statusText @Common.TextArrangement: #TextOnly;
};

annotate service.Students with @(
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'StudentInfo',
            Label : 'Student Information',
            Target: '@UI.FieldGroup#StudentInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'DepartmentInfo',
            Label : 'Department',
            Target: '@UI.FieldGroup#DeptInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AddressFacet',
            Label : 'Addresses',
            Target: 'addresses/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'EnrollmentFacet',
            Label : 'Course Enrollments',
            Target: 'enrollments/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AdminInfo',
            Label : 'Administrative Data',
            Target: '@UI.FieldGroup#AdminData'
        }
    ]
);

annotate service.Students with @(
    UI.FieldGroup #StudentInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: name,        Label: 'Student Name',        Position: 10 },
            { $Type: 'UI.DataField', Value: regno,        Label: 'Registration Number', Position: 20 },
            { $Type: 'UI.DataField', Value: email,        Label: 'Email',               Position: 30 },
            { $Type: 'UI.DataField', Value: phone,        Label: 'Phone Number',        Position: 40 },
            { $Type: 'UI.DataField', Value: dateOfBirth,  Label: 'Date of Birth',       Position: 50 },
            { $Type: 'UI.DataField', Value: status,       Label: 'Status',              Position: 60 }
        ]
    }
);

annotate service.Students with @(
    UI.FieldGroup #DeptInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: department_ID,   Label: 'Department',      Position: 10 },
            { $Type: 'UI.DataField', Value: department.code,  Label: 'Department Code', Position: 20 }
        ]
    }
);

annotate service.Students with @(
    UI.FieldGroup #AdminData: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By',      Position: 10 },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At',      Position: 20 },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By', Position: 30 },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At', Position: 40 }
        ]
    }
);

annotate service.Students with {
    name        @title: 'Student Name'       @Common.FieldControl: #Mandatory;
    regno       @title: 'Registration Number' @Common.FieldControl: #Mandatory;
    email       @title: 'Email';
    phone       @title: 'Phone Number';
    dateOfBirth @title: 'Date of Birth';
    status      @title: 'Status'
        @Common.ValueListWithFixedValues
        @Common.ValueList: {
            CollectionPath: 'Students',
            Label: 'Status',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: status, ValueListProperty: 'status' }
            ]
        };
    department  @title: 'Department'
        @Common.ValueList: {
            CollectionPath: 'Departments',
            Label: 'Departments',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',  LocalDataProperty: department_ID, ValueListProperty: 'ID'   },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'code' }
            ]
        };
};


////////////////////////////////////////////////////////////
// ─── ADDRESSES (child of Student) ──────────────────────
////////////////////////////////////////////////////////////

annotate service.Addresses with @(
    UI.HeaderInfo: {
        TypeName      : 'Address',
        TypeNamePlural: 'Addresses',
        Title         : { $Type: 'UI.DataField', Value: city },
        Description   : { $Type: 'UI.DataField', Value: addressType }
    }
);

annotate service.Addresses with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: addressType, Label: 'Type',        Position: 10 },
        { $Type: 'UI.DataField', Value: street,      Label: 'Street',      Position: 20 },
        { $Type: 'UI.DataField', Value: city,        Label: 'City',        Position: 30 },
        { $Type: 'UI.DataField', Value: state,       Label: 'State',       Position: 40 },
        { $Type: 'UI.DataField', Value: postalCode,  Label: 'Postal Code', Position: 50 },
        { $Type: 'UI.DataField', Value: country,     Label: 'Country',     Position: 60 }
    ]
);

annotate service.Addresses with @(
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AddressDetails',
            Label : 'Address Details',
            Target: '@UI.FieldGroup#AddressDetails'
        }
    ]
);

annotate service.Addresses with @(
    UI.FieldGroup #AddressDetails: {
        Data: [
            { $Type: 'UI.DataField', Value: addressType, Label: 'Address Type', Position: 10 },
            { $Type: 'UI.DataField', Value: street,      Label: 'Street',       Position: 20 },
            { $Type: 'UI.DataField', Value: city,        Label: 'City',         Position: 30 },
            { $Type: 'UI.DataField', Value: state,       Label: 'State',        Position: 40 },
            { $Type: 'UI.DataField', Value: postalCode,  Label: 'Postal Code',  Position: 50 },
            { $Type: 'UI.DataField', Value: country,     Label: 'Country',      Position: 60 }
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


////////////////////////////////////////////////////////////
// ─── ENROLLMENTS (child of Student, linked to Course) ──
////////////////////////////////////////////////////////////

annotate service.Enrollments with @(
    UI.HeaderInfo: {
        TypeName      : 'Enrollment',
        TypeNamePlural: 'Enrollments',
        Title         : { $Type: 'UI.DataField', Value: course.title },
        Description   : { $Type: 'UI.DataField', Value: enrollmentDate }
    }
);

annotate service.Enrollments with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: course_ID,       Label: 'Course',          Position: 10 },
        { $Type: 'UI.DataField', Value: course.title,    Label: 'Course Title',    Position: 20 },
        { $Type: 'UI.DataField', Value: course.credits,  Label: 'Credits',         Position: 30 },
        { $Type: 'UI.DataField', Value: enrollmentDate,  Label: 'Enrollment Date', Position: 40 },
        { $Type: 'UI.DataField', Value: grade,           Label: 'Grade',           Position: 50 },
        {
            $Type: 'UI.DataField', Value: status, Label: 'Status', Position: 60,
            Criticality: enrollStatusCriticality
        }
    ]
);

annotate service.Enrollments with @(
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'EnrollmentDetails',
            Label : 'Enrollment Details',
            Target: '@UI.FieldGroup#EnrollmentDetails'
        }
    ]
);

annotate service.Enrollments with @(
    UI.FieldGroup #EnrollmentDetails: {
        Data: [
            { $Type: 'UI.DataField', Value: course_ID,       Label: 'Course',          Position: 10 },
            { $Type: 'UI.DataField', Value: enrollmentDate,  Label: 'Enrollment Date', Position: 20 },
            { $Type: 'UI.DataField', Value: grade,           Label: 'Grade',           Position: 30 },
            { $Type: 'UI.DataField', Value: status,          Label: 'Status',          Position: 40 }
        ]
    }
);

annotate service.Enrollments with {
    course         @title: 'Course'
        @Common.ValueList: {
            CollectionPath: 'Courses',
            Label: 'Courses',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',         LocalDataProperty: course_ID, ValueListProperty: 'ID' },
                { $Type: 'Common.ValueListParameterDisplayOnly',   ValueListProperty: 'title'     },
                { $Type: 'Common.ValueListParameterDisplayOnly',   ValueListProperty: 'courseCode' },
                { $Type: 'Common.ValueListParameterDisplayOnly',   ValueListProperty: 'credits'   }
            ]
        };
    enrollmentDate @title: 'Enrollment Date' @Common.FieldControl: #Mandatory;
    grade          @title: 'Grade';
    status         @title: 'Enrollment Status';
};


////////////////////////////////////////////////////////////
// ─── COURSES ───────────────────────────────────────────
////////////////////////////////////////////////////////////

annotate service.Courses with @(
    UI.HeaderInfo: {
        TypeName      : 'Course',
        TypeNamePlural: 'Courses',
        Title         : { $Type: 'UI.DataField', Value: title },
        Description   : { $Type: 'UI.DataField', Value: courseCode }
    }
);

annotate service.Courses with @(
    UI.SelectionFields: [
        title,
        courseCode,
        department_ID
    ]
);

annotate service.Courses with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: courseCode,       Label: 'Course Code',  Position: 10 },
        { $Type: 'UI.DataField', Value: title,            Label: 'Title',        Position: 20 },
        { $Type: 'UI.DataField', Value: credits,          Label: 'Credits',      Position: 30 },
        { $Type: 'UI.DataField', Value: department.name,  Label: 'Department',   Position: 40 },
        { $Type: 'UI.DataField', Value: description,      Label: 'Description',  Position: 50 }
    ]
);

annotate service.Courses with @(
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'CourseInfo',
            Label : 'Course Details',
            Target: '@UI.FieldGroup#CourseInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'CourseEnrollments',
            Label : 'Enrolled Students',
            Target: 'enrollments/@UI.LineItem'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'CourseAdmin',
            Label : 'Administrative Data',
            Target: '@UI.FieldGroup#CourseAdmin'
        }
    ]
);

annotate service.Courses with @(
    UI.FieldGroup #CourseInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: courseCode,     Label: 'Course Code',  Position: 10 },
            { $Type: 'UI.DataField', Value: title,          Label: 'Title',        Position: 20 },
            { $Type: 'UI.DataField', Value: credits,        Label: 'Credits',      Position: 30 },
            { $Type: 'UI.DataField', Value: department_ID,  Label: 'Department',   Position: 40 },
            { $Type: 'UI.DataField', Value: description,    Label: 'Description',  Position: 50 }
        ]
    }
);

annotate service.Courses with @(
    UI.FieldGroup #CourseAdmin: {
        Data: [
            { $Type: 'UI.DataField', Value: createdBy,  Label: 'Created By',      Position: 10 },
            { $Type: 'UI.DataField', Value: createdAt,  Label: 'Created At',      Position: 20 },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Last Changed By', Position: 30 },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Last Changed At', Position: 40 }
        ]
    }
);

annotate service.Courses with {
    courseCode   @title: 'Course Code'  @Common.FieldControl: #Mandatory;
    title        @title: 'Course Title' @Common.FieldControl: #Mandatory;
    credits      @title: 'Credits'      @Common.FieldControl: #Mandatory;
    description  @title: 'Description';
    department   @title: 'Department'
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


////////////////////////////////////////////////////////////
// ─── DEPARTMENTS (read-only, value-help) ───────────────
////////////////////////////////////////////////////////////

annotate service.Departments with @(
    UI.HeaderInfo: {
        TypeName      : 'Department',
        TypeNamePlural: 'Departments',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: code }
    }
);

annotate service.Departments with @(
    UI.SelectionFields: [ name, code ]
);

annotate service.Departments with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: code,        Label: 'Code',          Position: 10 },
        { $Type: 'UI.DataField', Value: name,        Label: 'Name',          Position: 20 },
        { $Type: 'UI.DataField', Value: headOfDept,  Label: 'Head of Dept',  Position: 30 },
        { $Type: 'UI.DataField', Value: description, Label: 'Description',   Position: 40 }
    ]
);

annotate service.Departments with {
    code       @title: 'Department Code';
    name       @title: 'Department Name';
    headOfDept @title: 'Head of Department';
    description @title: 'Description';
};
