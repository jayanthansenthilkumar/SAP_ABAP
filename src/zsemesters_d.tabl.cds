@EndUserText.label : 'Semester Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zsemesters_d {

  key client         : abap.clnt not null;
  key sem_id         : sysuuid_x16 not null;
  code               : abap.char(15);
  name               : abap.char(50);
  start_date         : abap.dats;
  end_date           : abap.dats;
  is_current         : abap_boolean;
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}