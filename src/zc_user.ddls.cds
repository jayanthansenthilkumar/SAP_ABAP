@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User Login Portal Projection View'
@Metadata.allowExtensions: true
@Search.searchable: true
define root view entity ZC_USER
  provider contract transactional_query
  as projection on ZI_USER
{
  key UserId,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Username,

      @Search.defaultSearchElement: true
      Email,

      Role,
      DisplayName,
      IsActive,
      LastLoginAt,
      StudentId,
      ProfessorId,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Student,
      _Professor
}