@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Department Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_DEPARTMENT
  provider contract transactional_query
  as projection on ZI_DEPARTMENT
{
  key DeptId,

      @Search.defaultSearchElement: true
      Code,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Name,

      Description,
      HeadOfDept,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged
}
