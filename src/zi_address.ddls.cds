@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Address Interface View'
define view entity ZI_ADDRESS
  as select from zaddresses
  association to parent ZI_STUDENT as _Student on $projection.StudentId = _Student.Sid
{
  key address_id       as AddressId,
      student_id       as StudentId,
      address_type     as AddressType,
      street           as Street,
      city             as City,
      state            as State,
      postal_code      as PostalCode,
      country          as Country,

      @Semantics.user.createdBy: true
      created_by       as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by  as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed as LocalLastChanged,

      _Student
}
