@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Semester Interface View'
define root view entity ZI_SEMESTER
  as select from zsemesters
{
  key sem_id           as SemId,
      code             as Code,
      name             as Name,
      start_date       as StartDate,
      end_date         as EndDate,
      is_current       as IsCurrent,

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