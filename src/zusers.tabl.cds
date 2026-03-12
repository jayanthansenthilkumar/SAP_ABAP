@EndUserText.label : 'User Login Portal Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zusers {

  key client         : abap.clnt not null;
  key user_id        : sysuuid_x16 not null;
  username           : abap.char(50);
  email              : abap.char(100);
  role               : abap.char(10);
  display_name       : abap.char(100);
  is_active          : abap_boolean;
  last_login_at      : timestampl;
  student_id         : sysuuid_x16;
  professor_id       : sysuuid_x16;
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;

}