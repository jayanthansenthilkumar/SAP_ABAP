@EndUserText.label : 'Enrollment Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zenrollments {

  key client         : abap.clnt not null;
  key enrollment_id  : sysuuid_x16 not null;
  student_id         : sysuuid_x16 not null;
  course_id          : sysuuid_x16;
  enrollment_date    : abap.dats;
  grade              : abap.char(2);
  status             : abap.char(1);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;

}
