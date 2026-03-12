@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Course Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_COURSE
  provider contract transactional_query
  as projection on ZI_COURSE
{
  key CourseId,

      @Search.defaultSearchElement: true
      CourseCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Title,

      Credits,
      Description,
      DepartmentId,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Department
}
