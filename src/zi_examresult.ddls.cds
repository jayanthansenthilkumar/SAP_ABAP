@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exam Result Interface View'
define view entity ZI_EXAMRESULT
  as select from zexamresults
  association to parent ZI_STUDENT       as _Student      on $projection.StudentId      = _Student.Sid
  association [0..1] to ZI_EXAMSCHEDULE  as _ExamSchedule on $projection.ExamScheduleId = _ExamSchedule.ExamId
{
  key result_id        as ResultId,
      student_id       as StudentId,
      exam_schedule_id as ExamScheduleId,
      marks_obtained   as MarksObtained,
      grade            as Grade,
      is_passed        as IsPassed,
      remarks          as Remarks,
      result_status    as ResultStatus,
      published_at     as PublishedAt,
      published_by     as PublishedBy,

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
      _ExamSchedule
}