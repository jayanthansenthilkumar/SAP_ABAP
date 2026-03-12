@EndUserText.label : 'Exam Schedule Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zexamschedules_d {

  key client         : abap.clnt not null;
  key exam_id        : sysuuid_x16 not null;
  course_id          : sysuuid_x16;
  semester_id        : sysuuid_x16;
  exam_type          : abap.char(10);
  exam_date          : abap.dats;
  start_time         : abap.tims;
  end_time           : abap.tims;
  venue              : abap.char(100);
  max_marks          : abap.int4;
  passing_marks      : abap.int4;
  instructions       : abap.char(500);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}