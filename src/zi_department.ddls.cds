@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department Interface View'
define root view entity ZI_DEPARTMENT
  as select from zdepartments
{
  key dept_id          as DeptId,
      code             as Code,
      name             as Name,
      description      as Description,
      head_of_dept     as HeadOfDept,

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
