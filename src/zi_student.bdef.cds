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

  draft action Edit;
  draft action Activate optimized;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare
  {
    validation ValidatePhone;
    validation ValidateName;
    validation ValidateRegno;
  }

  validation ValidatePhone on save { create; update; field Phone; }
  validation ValidateName  on save { create; update; field Name;  }
  validation ValidateRegno on save { create; update; field Regno; }

  mapping for zstudentss corresponding
  {
    Sid              = sid;
    Name             = name;
    Regno            = regno;
    Phone            = phone;
    CreatedBy        = created_by;
    CreatedAt        = created_at;
    LastChangedBy    = last_changed_by;
    LastChangedAt    = last_changed_at;
    LocalLastChanged = local_last_changed;
  }
}
