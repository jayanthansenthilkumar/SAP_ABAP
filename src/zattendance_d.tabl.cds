@EndUserText.label : 'Attendance Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zattendance_d {

  key client         : abap.clnt not null;
  key attend_id      : sysuuid_x16 not null;
  student_id         : sysuuid_x16;
  course_id          : sysuuid_x16;
  semester_id        : sysuuid_x16;
  attendance_date    : abap.dats;
  status             : abap.char(1);
  remarks            : abap.char(200);
  created_by         : syuname;
  created_at         : timestampl;
  last_changed_by    : syuname;
  last_changed_at    : timestampl;
  local_last_changed : timestampl;
  "%admin"           : include sych_bdl_draft_admin_inc;

}