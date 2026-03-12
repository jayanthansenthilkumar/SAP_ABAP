@EndUserText.label : 'Course Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zcourses_d {

  key client         : abap.clnt not null;
  key course_id      : sysuuid_x16 not null;
  course_code        : abap.char(15);
  title              : abap.char(150);
  credits            : abap.int4;
  description        : abap.char(500);
  department_id      : sysuuid_x16;
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}
