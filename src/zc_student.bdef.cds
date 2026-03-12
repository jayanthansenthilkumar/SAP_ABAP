projection;
strict ( 2 );
use draft;

define behavior for ZC_STUDENT alias Student
{
  use create;
  use update;
  use delete;

  use association _Address    { create; }
  use association _Enrollment { create; }
  use association _ExamResult { create; }

  use action Edit;
  use action Activate;
  use action Discard;
  use action Resume;
  use action Prepare;
}

define behavior for ZC_ADDRESS alias Address
{
  use update;
  use delete;

  use association _Student;
}

define behavior for ZC_ENROLLMENT alias Enrollment
{
  use update;
  use delete;

  use association _Student;
}

define behavior for ZC_EXAMRESULT alias ExamResult
{
  use update;
  use delete;

  use association _Student;
}
