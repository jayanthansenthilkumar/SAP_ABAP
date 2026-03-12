@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Professor Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_PROFESSOR
  provider contract transactional_query
  as projection on ZI_PROFESSOR
{
  key ProfId,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Name,

      @Search.defaultSearchElement: true
      EmployeeId,

      @Search.defaultSearchElement: true
      Email,

      Phone,
      Specialization,
      DepartmentId,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Department
}