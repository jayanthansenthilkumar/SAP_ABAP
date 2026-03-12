@EndUserText.label : 'Department Master Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zdepartments {

  key client         : abap.clnt not null;
  key dept_id        : sysuuid_x16 not null;
  code               : abap.char(10);
  name               : abap.char(100);
  description        : abap.char(500);
  head_of_dept       : abap.char(100);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;

}
