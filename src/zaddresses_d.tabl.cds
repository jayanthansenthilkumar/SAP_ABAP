@EndUserText.label : 'Address Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zaddresses_d {

  key client         : abap.clnt not null;
  key address_id     : sysuuid_x16 not null;
  student_id         : sysuuid_x16 not null;
  address_type       : abap.char(10);
  street             : abap.char(200);
  city               : abap.char(100);
  state              : abap.char(100);
  postal_code        : abap.char(20);
  country            : abap.char(50);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}
