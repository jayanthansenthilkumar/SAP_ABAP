@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attendance Interface View'
define root view entity ZI_ATTENDANCE
  as select from zattendance
  association [0..1] to ZI_STUDENT  as _Student  on $projection.StudentId  = _Student.Sid
  association [0..1] to ZI_COURSE   as _Course   on $projection.CourseId   = _Course.CourseId
  association [0..1] to ZI_SEMESTER as _Semester on $projection.SemesterId = _Semester.SemId
{
  key attend_id        as AttendId,
      student_id       as StudentId,
      course_id        as CourseId,
      semester_id      as SemesterId,
      attendance_date  as AttendanceDate,
      status           as Status,
      remarks          as Remarks,

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
      _Course,
      _Semester
}