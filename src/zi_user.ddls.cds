@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User Login Portal Interface View'
define root view entity ZI_USER
  as select from zusers
  association [0..1] to ZI_STUDENT   as _Student   on $projection.StudentId   = _Student.Sid
  association [0..1] to ZI_PROFESSOR as _Professor on $projection.ProfessorId = _Professor.ProfId
{
  key user_id          as UserId,
      username         as Username,
      email            as Email,
      role             as Role,
      display_name     as DisplayName,
      is_active        as IsActive,
      last_login_at    as LastLoginAt,
      student_id       as StudentId,
      professor_id     as ProfessorId,

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

      _Student,
      _Professor
}