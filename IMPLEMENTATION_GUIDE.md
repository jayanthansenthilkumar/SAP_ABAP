# Student Management System — ABAP RAP on SAP BTP

## Complete Implementation Guide

---

## Architecture

```
ZSTUDENTSS (DB Table)  +  ZSTUDENTSS_D (Draft Table)
        ↓
ZI_STUDENT (Interface CDS View Entity)
        ↓
ZI_STUDENT (Behavior Definition — managed, draft-enabled)
        ↓
ZBP_I_STUDENT (Behavior Implementation Class)
        ↓
ZC_STUDENT (Projection CDS View Entity)
        ↓
ZC_STUDENT (Behavior Projection)
        ↓
ZC_STUDENT (Metadata Extension — Fiori UI annotations)
        ↓
ZUI_STUDENT (Service Definition)
        ↓
ZUI_STUDENT_O4 (Service Binding — OData V4 UI)
        ↓
Fiori Elements List Report + Object Page
```

---

## Files Delivered

| # | File | Object Type | Purpose |
|---|------|------------|---------|
| 1 | `zstudentss.tabl.cds` | CDS Table | Student master data table |
| 2 | `zstudentss_d.tabl.cds` | CDS Table | Draft table for draft-enabled transactions |
| 3 | `zi_student.ddls.cds` | CDS View Entity | Interface (BO) view on student table |
| 4 | `zi_student.bdef.cds` | Behavior Definition | Managed CRUD + draft + validations |
| 5 | `zbp_i_student.clas.abap` | ABAP Class | Behavior implementation (global class) |
| 6 | `zbp_i_student.clas.locals_imp.abap` | ABAP Local Class | Validation logic (phone, name, regno) |
| 7 | `zc_student.ddls.cds` | CDS View Entity | Projection view for UI consumption |
| 8 | `zc_student.bdef.cds` | Behavior Projection | Exposes CRUD + draft to projection |
| 9 | `zc_student.ddls.metadataext` | Metadata Extension | Fiori Elements UI annotations |
| 10 | `zui_student.srvd.cds` | Service Definition | Exposes projection as OData service |
| 11 | `zui_student_o4.srvb.json` | Reference | Service Binding config (create in ADT) |

---

## Step-by-Step Creation in ADT (Eclipse)

### Prerequisites
- SAP BTP ABAP Environment instance provisioned
- Eclipse with ADT plugin installed
- ABAP Cloud project created and connected

### Step 1: Create the Database Table
1. Right-click your package → **New → Other ABAP Repository Object → Dictionary → Database Table**
2. Name: `ZSTUDENTSS`
3. Paste the content from `zstudentss.tabl.cds`
4. **Activate** (Ctrl+F3)

### Step 2: Create the Draft Table
1. Same as Step 1, name: `ZSTUDENTSS_D`
2. Paste content from `zstudentss_d.tabl.cds`
3. **Activate**

### Step 3: Create the Interface CDS View Entity
1. Right-click package → **New → Other ABAP Repository Object → Core Data Services → Data Definition**
2. Name: `ZI_STUDENT`
3. Choose template: **Define Root View Entity**
4. Replace content with `zi_student.ddls.cds`
5. **Activate**

### Step 4: Create the Behavior Definition
1. Right-click `ZI_STUDENT` → **New Behavior Definition**
2. Implementation Type: **Managed**
3. Replace content with `zi_student.bdef.cds`
4. **Activate**

### Step 5: Create the Behavior Implementation Class
1. Place cursor on `zbp_i_student` in the behavior definition → Quick Fix (Ctrl+1) → **Create behavior implementation class**
2. Or manually: New → ABAP Class → `ZBP_I_STUDENT`
3. Paste the global class from `zbp_i_student.clas.abap`
4. Paste the local handler class from `zbp_i_student.clas.locals_imp.abap` into the **Local Types** tab
5. **Activate**

### Step 6: Create the Projection CDS View Entity
1. New → Data Definition → Name: `ZC_STUDENT`
2. Choose template: **Define Projection View**
3. Replace content with `zc_student.ddls.cds`
4. **Activate**

### Step 7: Create the Behavior Projection
1. Right-click `ZC_STUDENT` → **New Behavior Definition**
2. Replace content with `zc_student.bdef.cds`
3. **Activate**

### Step 8: Create the Metadata Extension
1. Right-click `ZC_STUDENT` → **New Metadata Extension**
2. Name: `ZC_STUDENT` (same name, different object type)
3. Replace content with `zc_student.ddls.metadataext`
4. **Activate**

### Step 9: Create the Service Definition
1. Right-click package → **New → Other ABAP Repository Object → Business Services → Service Definition**
2. Name: `ZUI_STUDENT`
3. Paste content from `zui_student.srvd.cds`
4. **Activate**

### Step 10: Create the Service Binding
1. Right-click package → **New → Other ABAP Repository Object → Business Services → Service Binding**
2. Name: `ZUI_STUDENT_O4`
3. Binding Type: **OData V4 - UI**
4. Service Definition: `ZUI_STUDENT`
5. **Activate**
6. Click **Publish** in the Service Binding editor

### Step 11: Preview the Fiori App
1. In the Service Binding editor, select entity set `Student`
2. Click **Preview** button
3. The Fiori Elements List Report opens in the browser

---

## Features Included

### CRUD Operations
- **Create**: Add new student records via the Fiori "Create" button
- **Read**: List Report displays all students with sorting/filtering
- **Update**: Click a student → Object Page → Edit
- **Delete**: Select rows → Delete button

### Draft Handling
- Users can start editing and save as draft without committing
- Draft data stored in `ZSTUDENTSS_D`
- Activate action commits the draft to the active table

### Validations (triggered on save / Prepare)
| Validation | Rule |
|-----------|------|
| `ValidatePhone` | Phone must contain only digits (regex `^\d+$`) |
| `ValidateName` | Name is mandatory |
| `ValidateRegno` | Registration number is mandatory |

### Search & Filter
- `@Search.searchable` on projection view enables global search
- `@Search.defaultSearchElement` on Name and Regno for fuzzy search
- `@UI.selectionField` on Name and Regno for filter bar fields

### Fiori UI Annotations
- List Report columns: Name, Regno, Phone
- Object Page with two facets: Student Information + Administrative Data
- Header shows student Name and Regno
- Administrative fields (CreatedBy, CreatedAt, etc.) in a separate section

### Field Control
- `Sid` (key) is auto-generated via `numbering : managed` (UUID)
- Admin fields (`CreatedBy`, `CreatedAt`, `LastChangedBy`, `LastChangedAt`, `LocalLastChanged`) are read-only
- ETag support via `LocalLastChanged` for optimistic concurrency

---

## Data Model

| Field | Type | Description |
|-------|------|-------------|
| `sid` | `sysuuid_x16` | Primary key (UUID, auto-generated) |
| `name` | `char(50)` | Student full name |
| `regno` | `char(20)` | Registration number |
| `phone` | `char(15)` | Phone number |
| `created_by` | `syuname` | Created by (system-filled) |
| `created_at` | `timestampl` | Created timestamp (system-filled) |
| `last_changed_by` | `syuname` | Last changed by (system-filled) |
| `last_changed_at` | `timestampl` | Last changed timestamp (system-filled) |
| `local_last_changed` | `timestampl` | Local ETag (system-filled) |

---

## Troubleshooting

| Issue | Solution |
|-------|---------|
| Service Binding won't publish | Check all objects are activated without errors |
| Draft not working | Ensure draft table `ZSTUDENTSS_D` exists and includes `sych_bdl_draft_admin_inc` |
| Validations not firing | Ensure `draft determine action Prepare` references the validations |
| Search not working | Verify `@Search.searchable` on projection and `@Search.defaultSearchElement` on fields |
| No columns in List Report | Ensure Metadata Extension is activated with `@UI.lineItem` annotations |
