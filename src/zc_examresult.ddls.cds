@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exam Result Projection View'
@Metadata.allowExtensions: true
define view entity ZC_EXAMRESULT
  as projection on ZI_EXAMRESULT
{
  key ResultId,
      StudentId,
      ExamScheduleId,
      MarksObtained,
      Grade,
      IsPassed,
      Remarks,
      ResultStatus,
      PublishedAt,
      PublishedBy,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Student : redirected to parent ZC_STUDENT,
      _ExamSchedule
}