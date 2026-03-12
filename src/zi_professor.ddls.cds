@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Professor Interface View'
define root view entity ZI_PROFESSOR
  as select from zprofessors
  association [0..1] to ZI_DEPARTMENT as _Department on $projection.DepartmentId = _Department.DeptId
{
  key prof_id          as ProfId,
      name             as Name,
      employee_id      as EmployeeId,
      email            as Email,
      phone            as Phone,
      specialization   as Specialization,
      department_id    as DepartmentId,

      @Semantics.user.createdBy: true
      created_by       as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by  as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged,

      _Department
}