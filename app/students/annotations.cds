using StudentService as service from '../../srv/student-service';

////////////////////////////////////////////////////////////
// List Report + Object Page Annotations for Students
////////////////////////////////////////////////////////////

// Header info for the Object Page
annotate service.Students with @(
    UI.HeaderInfo: {
        TypeName      : 'Student',
        TypeNamePlural: 'Students',
        Title         : { $Type: 'UI.DataField', Value: name },
        Description   : { $Type: 'UI.DataField', Value: regno }
    }
);

// Selection fields shown in the filter bar
annotate service.Students with @(
    UI.SelectionFields: [
        name,
        regno
    ]
);

// Columns in the List Report table
annotate service.Students with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name,       Label: 'Student Name',         Position: 10 },
        { $Type: 'UI.DataField', Value: regno,       Label: 'Registration Number',  Position: 20 },
        { $Type: 'UI.DataField', Value: phone,       Label: 'Phone Number',         Position: 30 },
        { $Type: 'UI.DataField', Value: createdAt,   Label: 'Created At',           Position: 40 },
        { $Type: 'UI.DataField', Value: modifiedAt,  Label: 'Last Changed At',      Position: 50 }
    ]
);

// Object Page facets
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
            ID    : 'AdminInfo',
            Label : 'Administrative Data',
            Target: '@UI.FieldGroup#AdminData'
        }
    ]
);

// Student Information field group
annotate service.Students with @(
    UI.FieldGroup #StudentInfo: {
        Data: [
            { $Type: 'UI.DataField', Value: name,  Label: 'Student Name',        Position: 10 },
            { $Type: 'UI.DataField', Value: regno, Label: 'Registration Number', Position: 20 },
            { $Type: 'UI.DataField', Value: phone, Label: 'Phone Number',        Position: 30 }
        ]
    }
);

// Administrative Data field group
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

// Field-level labels
annotate service.Students with {
    name  @title: 'Student Name'        @Common.FieldControl: #Mandatory;
    regno @title: 'Registration Number'  @Common.FieldControl: #Mandatory;
    phone @title: 'Phone Number';
};
