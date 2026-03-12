@EndUserText.label: 'Student Management Service'
define service ZUI_STUDENT {
  expose ZC_STUDENT     as Student;
  expose ZC_ADDRESS     as Address;
  expose ZC_ENROLLMENT  as Enrollment;
  expose ZC_COURSE      as Course;
  expose ZC_DEPARTMENT  as Department;
}
