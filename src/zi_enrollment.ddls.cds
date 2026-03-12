@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Enrollment Interface View'
define view entity ZI_ENROLLMENT
  as select from zenrollments
  association to parent ZI_STUDENT as _Student on $projection.StudentId = _Student.Sid
  association [0..1] to ZI_COURSE  as _Course  on $projection.CourseId  = _Course.CourseId
{
  key enrollment_id    as EnrollmentId,
      student_id       as StudentId,
      course_id        as CourseId,
      enrollment_date  as EnrollmentDate,
      grade            as Grade,
      status           as Status,

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
      _Course
}
