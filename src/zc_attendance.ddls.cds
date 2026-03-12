@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attendance Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_ATTENDANCE
  provider contract transactional_query
  as projection on ZI_ATTENDANCE
{
  key AttendId,

      StudentId,
      CourseId,
      SemesterId,
      AttendanceDate,

      @Search.defaultSearchElement: true
      Status,

      Remarks,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Student,
      _Course,
      _Semester
}