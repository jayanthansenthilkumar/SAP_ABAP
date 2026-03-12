namespace student.management;

using { cuid, managed } from '@sap/cds/common';

/**
 * Student Master Entity
 * - cuid provides a UUID-based key field (ID)
 * - managed provides createdAt, createdBy, modifiedAt, modifiedBy
 */
entity Students : cuid, managed {
    name   : String(50)  @mandatory;
    regno  : String(20)  @mandatory;
    phone  : String(15);
}
