@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Interface View'
define root view entity ZI_STUDENT
  as select from zstudentss
{
  key sid              as Sid,
      name             as Name,
      regno            as Regno,
      phone            as Phone,

      -- Administrative fields
      @Semantics.user.createdBy: true
      created_by       as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by  as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged
}
