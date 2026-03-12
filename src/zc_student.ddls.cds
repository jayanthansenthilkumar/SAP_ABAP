@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Student Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_STUDENT
  provider contract transactional_query
  as projection on ZI_STUDENT
{
  key Sid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Name,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Regno,

      Phone,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged
}
