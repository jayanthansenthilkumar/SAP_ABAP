/**
 * Student Service - Custom Handlers
 * Implements validation logic for all entities
 */
const cds = require('@sap/cds');

module.exports = class StudentService extends cds.ApplicationService {

    init() {
        const { Students, Courses, Enrollments, Addresses } = this.entities;

        // ── Student Validations ───────────────────────────────
        this.before(['CREATE', 'UPDATE'], Students, async (req) => {
            const { name, regno, phone, email, status } = req.data;

            if (name !== undefined && !name?.trim()) {
                req.error(400, 'Student name is required.', 'name');
            }

            if (regno !== undefined && !regno?.trim()) {
                req.error(400, 'Registration number is required.', 'regno');
            }

            if (phone !== undefined && phone !== null && phone.trim() !== '') {
                if (!/^\d+$/.test(phone)) {
                    req.error(400, 'Phone number must contain only digits.', 'phone');
                }
            }

            if (email !== undefined && email !== null && email.trim() !== '') {
                if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    req.error(400, 'Please enter a valid email address.', 'email');
                }
            }

            if (status !== undefined && !['A', 'I', 'G'].includes(status)) {
                req.error(400, 'Status must be A (Active), I (Inactive), or G (Graduated).', 'status');
            }
        });

        // ── Course Validations ────────────────────────────────
        this.before(['CREATE', 'UPDATE'], Courses, async (req) => {
            const { title, courseCode, credits } = req.data;

            if (title !== undefined && !title?.trim()) {
                req.error(400, 'Course title is required.', 'title');
            }

            if (courseCode !== undefined && !courseCode?.trim()) {
                req.error(400, 'Course code is required.', 'courseCode');
            }

            if (credits !== undefined && credits !== null) {
                if (credits < 1 || credits > 10) {
                    req.error(400, 'Credits must be between 1 and 10.', 'credits');
                }
            }
        });

        // ── Enrollment Validations ────────────────────────────
        this.before(['CREATE', 'UPDATE'], Enrollments, async (req) => {
            const { enrollmentDate, grade, status } = req.data;

            if (enrollmentDate !== undefined && !enrollmentDate) {
                req.error(400, 'Enrollment date is required.', 'enrollmentDate');
            }

            if (grade !== undefined && grade !== null && grade.trim() !== '') {
                const validGrades = ['A', 'A+', 'B+', 'B', 'C+', 'C', 'D', 'F'];
                if (!validGrades.includes(grade.toUpperCase())) {
                    req.error(400, 'Grade must be one of: A, A+, B+, B, C+, C, D, F.', 'grade');
                }
            }

            if (status !== undefined && !['E', 'C', 'D'].includes(status)) {
                req.error(400, 'Enrollment status must be E (Enrolled), C (Completed), or D (Dropped).', 'status');
            }
        });

        // ── Address Validations ───────────────────────────────
        this.before(['CREATE', 'UPDATE'], Addresses, async (req) => {
            const { addressType } = req.data;

            if (addressType !== undefined && addressType !== null) {
                const validTypes = ['HOME', 'MAIL', 'TEMP'];
                if (!validTypes.includes(addressType.toUpperCase())) {
                    req.error(400, 'Address type must be HOME, MAIL, or TEMP.', 'addressType');
                }
            }
        });

        // ── Change Student Status Action ──────────────────────
        this.on('changeStudentStatus', async (req) => {
            const { studentId, newStatus } = req.data;

            if (!['A', 'I', 'G'].includes(newStatus)) {
                req.error(400, 'Invalid status. Must be A, I, or G.');
            }

            await UPDATE(Students).set({ status: newStatus }).where({ ID: studentId });
            return SELECT.one.from(Students).where({ ID: studentId });
        });

        return super.init();
    }

};
