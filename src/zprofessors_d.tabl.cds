@EndUserText.label : 'Professor Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zprofessors_d {

  key client         : abap.clnt not null;
  key prof_id        : sysuuid_x16 not null;
  name               : abap.char(100);
  employee_id        : abap.char(20);
  email              : abap.char(100);
  phone              : abap.char(15);
  specialization     : abap.char(200);
  department_id      : sysuuid_x16;
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}