@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Address Projection View'
@Metadata.allowExtensions: true
define view entity ZC_ADDRESS
  as projection on ZI_ADDRESS
{
  key AddressId,
      StudentId,
      AddressType,
      Street,
      City,
      State,
      PostalCode,
      Country,

      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChanged,

      _Student : redirected to parent ZC_STUDENT
}
