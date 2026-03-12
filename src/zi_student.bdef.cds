managed implementation in class zbp_i_student unique;
strict ( 2 );
with draft;

define behavior for ZI_STUDENT alias Student
persistent table zstudentss
draft table zstudentss_d
lock master total etag LastChangedAt
authorization master ( instance )
etag master LocalLastChanged
{
  field ( readonly )
    Sid,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChanged;

  field ( numbering : managed )
    Sid;

  create;
  update;
  delete;

  association _Address    { create; }
  association _Enrollment { create; }
  association _ExamResult { create; }

  draft action Edit;
  draft action Activate optimized;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare
  {
    validation ValidatePhone;
    validation ValidateName;
    validation ValidateRegno;
    validation ValidateEmail;
  }

  validation ValidatePhone on save { create; update; field Phone; }
  validation ValidateName  on save { create; update; field Name;  }
  validation ValidateRegno on save { create; update; field Regno; }
  validation ValidateEmail on save { create; update; field Email; }

  mapping for zstudentss corresponding
  {
    Sid              = sid;
    Name             = name;
    Regno            = regno;
    Email            = email;
    Phone            = phone;
    DateOfBirth      = date_of_birth;
    Status           = status;
    DepartmentId     = department_id;
    CreatedBy        = created_by;
    CreatedAt        = created_at;
    LastChangedBy    = last_changed_by;
    LastChangedAt    = last_changed_at;
    LocalLastChanged = local_last_changed;
  }
}

define behavior for ZI_ADDRESS alias Address
persistent table zaddresses
draft table zaddresses_d
lock dependent by _Student
authorization dependent by _Student
etag master LocalLastChanged
{
  field ( readonly )
    AddressId,
    StudentId;

  field ( numbering : managed )
    AddressId;

  update;
  delete;

  association _Student;

  mapping for zaddresses corresponding
  {
    AddressId        = address_id;
    StudentId        = student_id;
    AddressType      = address_type;
    Street           = street;
    City             = city;
    State            = state;
    PostalCode       = postal_code;
    Country          = country;
    CreatedBy        = created_by;
    CreatedAt        = created_at;
    LastChangedBy    = last_changed_by;
    LastChangedAt    = last_changed_at;
    LocalLastChanged = local_last_changed;
  }
}

define behavior for ZI_ENROLLMENT alias Enrollment
persistent table zenrollments
draft table zenrollments_d
lock dependent by _Student
authorization dependent by _Student
etag master LocalLastChanged
{
  field ( readonly )
    EnrollmentId,
    StudentId;

  field ( numbering : managed )
    EnrollmentId;

  update;
  delete;

  association _Student;

  mapping for zenrollments corresponding
  {
    EnrollmentId     = enrollment_id;
    StudentId        = student_id;
    CourseId         = course_id;
    SemesterId       = semester_id;
    EnrollmentDate   = enrollment_date;
    Grade            = grade;
    Status           = status;
    CreatedBy        = created_by;
    CreatedAt        = created_at;
    LastChangedBy    = last_changed_by;
    LastChangedAt    = last_changed_at;
    LocalLastChanged = local_last_changed;
  }
}

define behavior for ZI_EXAMRESULT alias ExamResult
persistent table zexamresults
draft table zexamresults_d
lock dependent by _Student
authorization dependent by _Student
etag master LocalLastChanged
{
  field ( readonly )
    ResultId,
    StudentId;

  field ( numbering : managed )
    ResultId;

  update;
  delete;

  association _Student;

  mapping for zexamresults corresponding
  {
    ResultId         = result_id;
    StudentId        = student_id;
    ExamScheduleId   = exam_schedule_id;
    MarksObtained    = marks_obtained;
    Grade            = grade;
    IsPassed         = is_passed;
    Remarks          = remarks;
    ResultStatus     = result_status;
    PublishedAt      = published_at;
    PublishedBy      = published_by;
    CreatedBy        = created_by;
    CreatedAt        = created_at;
    LastChangedBy    = last_changed_by;
    LastChangedAt    = last_changed_at;
    LocalLastChanged = local_last_changed;
  }
}
