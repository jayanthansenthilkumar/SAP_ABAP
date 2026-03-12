using { student.management as sm } from '../db/schema';

/**
 * Student Management Service
 * Exposes all entities with full CRUD, draft support, and academic features
 */
service StudentService @(path: '/student') {

    // ── Students (draft-enabled) ────────────────────────────
    @odata.draft.enabled
    entity Students    as projection on sm.Students {
        *,
        case status
            when 'A' then 3
            when 'I' then 1
            when 'G' then 2
            else 0
        end as statusCriticality   : Integer,
        case status
            when 'A' then 'Active'
            when 'I' then 'Inactive'
            when 'G' then 'Graduated'
            else 'Unknown'
        end as statusText          : String
    };

    entity Addresses   as projection on sm.Addresses;

    entity Enrollments as projection on sm.Enrollments {
        *,
        case status
            when 'E' then 2
            when 'C' then 3
            when 'D' then 1
            else 0
        end as enrollStatusCriticality : Integer
    };

    // ── Courses (draft-enabled, with professor join) ────────
    @odata.draft.enabled
    entity Courses     as projection on sm.Courses;

    entity Departments as projection on sm.Departments;

    // ── Professors (draft-enabled) ──────────────────────────
    @odata.draft.enabled
    entity Professors  as projection on sm.Professors;

    // ── Semesters (draft-enabled) ───────────────────────────
    @odata.draft.enabled
    entity Semesters   as projection on sm.Semesters {
        *,
        case isCurrent
            when true  then 3
            when false then 0
            else 0
        end as currentCriticality : Integer
    };

    // ── Exam Schedules (draft-enabled, joins Course+Semester) ─
    @odata.draft.enabled
    entity ExamSchedules as projection on sm.ExamSchedules {
        *,
        case examType
            when 'FINAL' then 1
            when 'MID'   then 2
            when 'QUIZ'  then 3
            when 'PRAC'  then 5
            when 'INT'   then 0
            else 0
        end as examTypeCriticality : Integer
    };

    // ── Exam Results (child of Student, joins ExamSchedule) ─
    entity ExamResults as projection on sm.ExamResults {
        *,
        case resultStatus
            when 'D' then 2
            when 'P' then 3
            when 'W' then 1
            else 0
        end as resultStatusCriticality : Integer,
        case resultStatus
            when 'D' then 'Draft'
            when 'P' then 'Published'
            when 'W' then 'Withheld'
            else 'Unknown'
        end as resultStatusText : String,
        case isPassed
            when true  then 3
            when false then 1
            else 0
        end as passedCriticality : Integer
    };

    // ── Users (Login Portal, draft-enabled) ─────────────────
    @odata.draft.enabled
    entity Users as projection on sm.Users {
        *,
        case role
            when 'ADMIN' then 1
            when 'PROF'  then 2
            when 'STUD'  then 3
            else 0
        end as roleCriticality : Integer,
        case isActive
            when true  then 3
            when false then 1
            else 0
        end as activeCriticality : Integer
    };

    // ── Attendance (joins Student+Course+Semester) ──────────
    @odata.draft.enabled
    entity Attendance as projection on sm.Attendance {
        *,
        case status
            when 'P' then 3
            when 'A' then 1
            when 'L' then 2
            when 'E' then 5
            else 0
        end as attendanceCriticality : Integer,
        case status
            when 'P' then 'Present'
            when 'A' then 'Absent'
            when 'L' then 'Late'
            when 'E' then 'Excused'
            else 'Unknown'
        end as attendanceStatusText : String
    };

    // ── Actions ─────────────────────────────────────────────
    action changeStudentStatus(studentId : UUID, newStatus : String(1)) returns Students;
    action publishResults(examScheduleId : UUID) returns String;
    action recordAttendance(courseId : UUID, semesterId : UUID, attendanceDate : Date, studentIds : array of UUID, status : String(1)) returns String;
}
