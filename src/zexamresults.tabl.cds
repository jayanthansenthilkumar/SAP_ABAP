@EndUserText.label : 'Exam Results Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zexamresults {

  key client         : abap.clnt not null;
  key result_id      : sysuuid_x16 not null;
  student_id         : sysuuid_x16;
  exam_schedule_id   : sysuuid_x16;
  marks_obtained     : abap.int4;
  grade              : abap.char(2);
  is_passed          : abap_boolean;
  remarks            : abap.char(200);
  result_status      : abap.char(1);
  published_at       : timestampl;
  published_by       : abap.char(100);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;

}