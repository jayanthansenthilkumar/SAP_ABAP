@EndUserText.label : 'Student Master Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zstudentss {

  key client         : abap.clnt not null;
  key sid            : sysuuid_x16 not null;
  name               : abap.char(50);
  regno              : abap.char(20);
  phone              : abap.char(15);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;

}
