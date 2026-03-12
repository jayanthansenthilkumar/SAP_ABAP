@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exam Schedule Interface View'
define root view entity ZI_EXAMSCHEDULE
  as select from zexamschedules
  association [0..1] to ZI_COURSE   as _Course   on $projection.CourseId   = _Course.CourseId
  association [0..1] to ZI_SEMESTER as _Semester  on $projection.SemesterId = _Semester.SemId
{
  key exam_id          as ExamId,
      course_id        as CourseId,
      semester_id      as SemesterId,
      exam_type        as ExamType,
      exam_date        as ExamDate,
      start_time       as StartTime,
      end_time         as EndTime,
      venue            as Venue,
      max_marks        as MaxMarks,
      passing_marks    as PassingMarks,
      instructions     as Instructions,

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

      _Course,
      _Semester
}