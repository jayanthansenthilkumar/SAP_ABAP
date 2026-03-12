using { student.management as sm } from '../db/schema';

/**
 * Student Management Service
 * Exposes Students entity with draft support and full CRUD
 */
service StudentService @(path: '/student') {

    @odata.draft.enabled
    entity Students as projection on sm.Students;

}
