/**
 * Student Service - Custom Handlers
 * Implements validation logic for Student entity
 */
const cds = require('@sap/cds');

module.exports = class StudentService extends cds.ApplicationService {

    init() {
        const { Students } = this.entities;

        // Validation before CREATE and UPDATE
        this.before(['CREATE', 'UPDATE'], Students, async (req) => {
            const { name, regno, phone } = req.data;

            // Validate: Name is mandatory
            if (name !== undefined && !name?.trim()) {
                req.error(400, 'Student name is required.', 'name');
            }

            // Validate: Registration number is mandatory
            if (regno !== undefined && !regno?.trim()) {
                req.error(400, 'Registration number is required.', 'regno');
            }

            // Validate: Phone must contain only digits
            if (phone !== undefined && phone !== null && phone.trim() !== '') {
                if (!/^\d+$/.test(phone)) {
                    req.error(400, 'Phone number must contain only digits.', 'phone');
                }
            }
        });

        return super.init();
    }

};
