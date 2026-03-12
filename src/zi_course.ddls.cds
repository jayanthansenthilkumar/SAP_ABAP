@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Course Interface View'
define root view entity ZI_COURSE
  as select from zcourses
  association [0..1] to ZI_DEPARTMENT as _Department on $projection.DepartmentId = _Department.DeptId
{
  key course_id        as CourseId,
      course_code      as CourseCode,
      title            as Title,
      credits          as Credits,
      description      as Description,
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
