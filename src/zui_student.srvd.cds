@EndUserText.label: 'Student Management Service'
define service ZUI_STUDENT {
  expose ZC_STUDENT       as Student;
  expose ZC_ADDRESS       as Address;
  expose ZC_ENROLLMENT    as Enrollment;
  expose ZC_EXAMRESULT    as ExamResult;
  expose ZC_COURSE        as Course;
  expose ZC_DEPARTMENT    as Department;
  expose ZC_PROFESSOR     as Professor;
  expose ZC_SEMESTER      as Semester;
  expose ZC_EXAMSCHEDULE  as ExamSchedule;
  expose ZC_USER          as User;
  expose ZC_ATTENDANCE    as Attendance;
}
