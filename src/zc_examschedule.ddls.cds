@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Exam Schedule Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_EXAMSCHEDULE
  provider contract transactional_query
  as projection on ZI_EXAMSCHEDULE
{
  key ExamId,

      CourseId,
      SemesterId,

      @Search.defaultSearchElement: true
      ExamType,

      ExamDate,
      StartTime,
      EndTime,
      Venue,
      MaxMarks,
      PassingMarks,
      Instructions,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Course,
      _Semester
}