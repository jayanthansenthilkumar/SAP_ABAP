/**
 * Student Service - Custom Handlers
 * Implements validation logic and actions for all entities
 */
const cds = require('@sap/cds');

module.exports = class StudentService extends cds.ApplicationService {

    init() {
        const {
            Students, Courses, Enrollments, Addresses,
            Professors, Semesters, ExamSchedules, ExamResults,
            Users, Attendance
        } = this.entities;

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
            const { title, courseCode, credits, maxStudents } = req.data;

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
            if (maxStudents !== undefined && maxStudents !== null && maxStudents < 1) {
                req.error(400, 'Max students must be at least 1.', 'maxStudents');
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

        // ── Professor Validations ─────────────────────────────
        this.before(['CREATE', 'UPDATE'], Professors, async (req) => {
            const { name, employeeId, email } = req.data;

            if (name !== undefined && !name?.trim()) {
                req.error(400, 'Professor name is required.', 'name');
            }
            if (employeeId !== undefined && !employeeId?.trim()) {
                req.error(400, 'Employee ID is required.', 'employeeId');
            }
            if (email !== undefined && email !== null && email.trim() !== '') {
                if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    req.error(400, 'Please enter a valid email address.', 'email');
                }
            }
        });

        // ── Semester Validations ──────────────────────────────
        this.before(['CREATE', 'UPDATE'], Semesters, async (req) => {
            const { code, name, startDate, endDate } = req.data;

            if (code !== undefined && !code?.trim()) {
                req.error(400, 'Semester code is required.', 'code');
            }
            if (name !== undefined && !name?.trim()) {
                req.error(400, 'Semester name is required.', 'name');
            }
            if (startDate && endDate && new Date(startDate) >= new Date(endDate)) {
                req.error(400, 'End date must be after start date.', 'endDate');
            }
        });

        // ── Exam Schedule Validations ─────────────────────────
        this.before(['CREATE', 'UPDATE'], ExamSchedules, async (req) => {
            const { examType, examDate, startTime, endTime, maxMarks, passingMarks } = req.data;

            if (examType !== undefined && !['MID', 'FINAL', 'QUIZ', 'PRAC', 'INT'].includes(examType)) {
                req.error(400, 'Exam type must be MID, FINAL, QUIZ, PRAC, or INT.', 'examType');
            }
            if (examDate !== undefined && !examDate) {
                req.error(400, 'Exam date is required.', 'examDate');
            }
            if (startTime && endTime && startTime >= endTime) {
                req.error(400, 'End time must be after start time.', 'endTime');
            }
            if (passingMarks !== undefined && maxMarks !== undefined &&
                passingMarks !== null && maxMarks !== null && passingMarks > maxMarks) {
                req.error(400, 'Passing marks cannot exceed max marks.', 'passingMarks');
            }
        });

        // ── Exam Results Validations ──────────────────────────
        this.before(['CREATE', 'UPDATE'], ExamResults, async (req) => {
            const { marksObtained, resultStatus } = req.data;

            if (marksObtained !== undefined && marksObtained !== null && marksObtained < 0) {
                req.error(400, 'Marks obtained cannot be negative.', 'marksObtained');
            }
            if (resultStatus !== undefined && !['D', 'P', 'W'].includes(resultStatus)) {
                req.error(400, 'Result status must be D (Draft), P (Published), or W (Withheld).', 'resultStatus');
            }
        });

        // Auto-calculate grade and pass/fail when marks are entered
        this.before(['CREATE', 'UPDATE'], ExamResults, async (req) => {
            const { marksObtained, examSchedule_ID } = req.data;
            if (marksObtained !== undefined && marksObtained !== null && examSchedule_ID) {
                const exam = await SELECT.one.from(ExamSchedules)
                    .where({ ID: examSchedule_ID });
                if (exam) {
                    const percentage = (marksObtained / exam.maxMarks) * 100;
                    req.data.isPassed = marksObtained >= exam.passingMarks;
                    if (percentage >= 90) req.data.grade = 'A+';
                    else if (percentage >= 80) req.data.grade = 'A';
                    else if (percentage >= 70) req.data.grade = 'B+';
                    else if (percentage >= 60) req.data.grade = 'B';
                    else if (percentage >= 50) req.data.grade = 'C';
                    else if (percentage >= 40) req.data.grade = 'D';
                    else req.data.grade = 'F';
                }
            }
        });

        // ── User Validations ──────────────────────────────────
        this.before(['CREATE', 'UPDATE'], Users, async (req) => {
            const { username, email, role } = req.data;

            if (username !== undefined && !username?.trim()) {
                req.error(400, 'Username is required.', 'username');
            }
            if (email !== undefined && email !== null && email.trim() !== '') {
                if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    req.error(400, 'Please enter a valid email address.', 'email');
                }
            }
            if (role !== undefined && !['ADMIN', 'PROF', 'STUD'].includes(role)) {
                req.error(400, 'Role must be ADMIN, PROF, or STUD.', 'role');
            }
        });

        // Record lastLoginAt on READ for current user context
        this.before('READ', Users, async (req) => {
            // Placeholder - in production this would check auth context
        });

        // ── Attendance Validations ────────────────────────────
        this.before(['CREATE', 'UPDATE'], Attendance, async (req) => {
            const { status, attendanceDate } = req.data;

            if (attendanceDate !== undefined && !attendanceDate) {
                req.error(400, 'Attendance date is required.', 'attendanceDate');
            }
            if (status !== undefined && !['P', 'A', 'L', 'E'].includes(status)) {
                req.error(400, 'Status must be P (Present), A (Absent), L (Late), or E (Excused).', 'status');
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

        // ── Publish Results Action ────────────────────────────
        this.on('publishResults', async (req) => {
            const { examScheduleId } = req.data;
            if (!examScheduleId) {
                req.error(400, 'Exam Schedule ID is required.');
            }

            const results = await SELECT.from(ExamResults)
                .where({ examSchedule_ID: examScheduleId, resultStatus: 'D' });

            if (results.length === 0) {
                return 'No draft results found to publish.';
            }

            const now = new Date().toISOString();
            await UPDATE(ExamResults)
                .set({ resultStatus: 'P', publishedAt: now, publishedBy: 'Admin' })
                .where({ examSchedule_ID: examScheduleId, resultStatus: 'D' });

            return `Successfully published ${results.length} result(s).`;
        });

        // ── Record Attendance Action ──────────────────────────
        this.on('recordAttendance', async (req) => {
            const { courseId, semesterId, attendanceDate, studentIds, status } = req.data;

            if (!courseId || !semesterId || !attendanceDate || !studentIds?.length) {
                req.error(400, 'Course, semester, date, and student IDs are required.');
            }

            const entries = studentIds.map(sid => ({
                student_ID: sid,
                course_ID: courseId,
                semester_ID: semesterId,
                attendanceDate: attendanceDate,
                status: status || 'P'
            }));

            await INSERT.into(Attendance).entries(entries);
            return `Recorded attendance for ${entries.length} student(s).`;
        });

        return super.init();
    }
};
