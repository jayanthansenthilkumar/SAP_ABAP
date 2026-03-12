@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Enrollment Projection View'
@Metadata.allowExtensions: true
define view entity ZC_ENROLLMENT
  as projection on ZI_ENROLLMENT
{
  key EnrollmentId,
      StudentId,
      CourseId,
      EnrollmentDate,
      Grade,
      Status,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Student : redirected to parent ZC_STUDENT,
      _Course
}
