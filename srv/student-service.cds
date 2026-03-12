using { student.management as sm } from '../db/schema';

/**
 * Student Management Service
 * Exposes all entities with full CRUD and draft support
 */
service StudentService @(path: '/student') {

    @odata.draft.enabled
    entity Students    as projection on sm.Students {
        *,
        case status
            when 'A' then 3  // Green
            when 'I' then 1  // Red
            when 'G' then 2  // Yellow
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
            when 'E' then 2  // Yellow - in progress
            when 'C' then 3  // Green  - completed
            when 'D' then 1  // Red    - dropped
            else 0
        end as enrollStatusCriticality : Integer
    };

    @odata.draft.enabled
    entity Courses     as projection on sm.Courses;

    entity Departments as projection on sm.Departments;

    // Action on Students to change status
    action changeStudentStatus(studentId : UUID, newStatus : String(1)) returns Students;
}
