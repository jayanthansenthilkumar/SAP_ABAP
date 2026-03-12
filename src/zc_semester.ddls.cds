@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Semester Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_SEMESTER
  provider contract transactional_query
  as projection on ZI_SEMESTER
{
  key SemId,

      @Search.defaultSearchElement: true
      Code,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Name,

      StartDate,
      EndDate,
      IsCurrent,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged
}