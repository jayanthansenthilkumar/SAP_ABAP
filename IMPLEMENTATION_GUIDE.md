# Student Management System — Enhanced Implementation Guide

## Complete Implementation Guide (v2.0 — Multi-Entity)

---

## Architecture

```
┌──────────────────────────────────────────────────────────────────┐
│                      SAP Fiori Elements UI                       │
│  ┌──────────────────┐    ┌──────────────────┐                    │
│  │  Student List     │    │  Course List      │                   │
│  │  Report + Object  │    │  Report + Object  │                   │
│  │  Page (+ Address, │    │  Page             │                   │
│  │  Enrollments)     │    │                   │                   │
│  └──────┬───────────┘    └──────┬───────────┘                    │
│         └──────────┬────────────┘                                │
│              OData V4 Service  /student/                         │
│  ┌─────────────────────────────────────────┐                     │
│  │          SAP CAP Runtime                 │                    │
│  │   Validations · Draft · Actions          │                    │
│  └──────────────────┬──────────────────────┘                     │
│  ┌──────────────────┴──────────────────────┐                     │
│  │           SQLite Database                │                    │
│  │  Departments │ Courses │ Students        │                    │
│  │  Addresses   │ Enrollments               │                    │
│  └──────────────────────────────────────────┘                    │
└──────────────────────────────────────────────────────────────────┘
```

---

## Data Model (5 Entities)

| # | Entity         | Description                         | Relationship                    |
|---|---------------|------------------------------------|---------------------------------|
| 1 | **Departments** | Department master data            | Parent of Students & Courses    |
| 2 | **Courses**     | Course catalog                    | Linked to Departments           |
| 3 | **Students**    | Student records (draft-enabled)   | Belongs to Department           |
| 4 | **Addresses**   | Student addresses                 | Composition child of Students   |
| 5 | **Enrollments** | Student-Course enrollments        | Composition child of Students   |

### Entity Relationships
```
Departments ─── 1:N ───> Students
Departments ─── 1:N ───> Courses
Students    ─── 1:N ───> Addresses    (Composition — inline edit)
Students    ─── 1:N ───> Enrollments  (Composition — inline edit)
Courses     <── N:1 ───  Enrollments  (Association — value help)
```

---

## Files Delivered

### Database Tables (src/)
| File | Purpose |
|------|---------|
| `zstudentss.tabl.cds` | Student master table |
| `zstudentss_d.tabl.cds` | Student draft table |
| `zdepartments.tabl.cds` | Department master table |
| `zcourses.tabl.cds` | Course master table |
| `zcourses_d.tabl.cds` | Course draft table |
| `zaddresses.tabl.cds` | Address table |
| `zaddresses_d.tabl.cds` | Address draft table |
| `zenrollments.tabl.cds` | Enrollment table |
| `zenrollments_d.tabl.cds` | Enrollment draft table |

### CDS Views & Behaviors (src/)
| File | Purpose |
|------|---------|
| `zi_student.ddls.cds` | Student interface view (with associations) |
| `zi_department.ddls.cds` | Department interface view |
| `zi_course.ddls.cds` | Course interface view |
| `zi_address.ddls.cds` | Address interface view |
| `zi_enrollment.ddls.cds` | Enrollment interface view |
| `zc_student.ddls.cds` | Student projection view |
| `zc_department.ddls.cds` | Department projection view |
| `zc_course.ddls.cds` | Course projection view |
| `zc_address.ddls.cds` | Address projection view |
| `zc_enrollment.ddls.cds` | Enrollment projection view |
| `zi_student.bdef.cds` | Behavior definition (Student + Address + Enrollment) |
| `zc_student.bdef.cds` | Behavior projection |
| `zc_student.ddls.metadataext` | Fiori UI metadata extension |
| `zbp_i_student.clas.abap` | Behavior implementation class |
| `zbp_i_student.clas.locals_imp.abap` | Validation handlers |
| `zui_student.srvd.cds` | Service definition |
| `zui_student_o4.srvb.json` | Service binding reference |

### CAP Application
| File | Purpose |
|------|---------|
| `db/schema.cds` | Data model (5 entities with enums) |
| `db/data/seed-data.cds` | Sample data (5 depts, 10 courses, 3 students) |
| `srv/student-service.cds` | Service with criticality calculations |
| `srv/student-service.js` | Validation handlers for all entities |
| `app/students/annotations.cds` | Full UI annotations for all entities |
| `app/students/webapp/manifest.json` | App routing (students, addresses, enrollments) |

---

## Features

### CRUD Operations
- Full Create, Read, Update, Delete on **Students** and **Courses**
- Draft handling with Edit / Activate / Discard / Resume / Prepare
- Inline creation of **Addresses** and **Enrollments** from Student Object Page
- Read-only **Departments** entity (pre-seeded, used as value help)

### Validations
| Field | Entity | Rule |
|-------|--------|------|
| Name | Student | Required |
| Registration No | Student | Required |
| Email | Student | Valid email format (user@domain.ext) |
| Phone | Student | Digits only |
| Status | Student | A (Active), I (Inactive), G (Graduated) |
| Course Title | Course | Required |
| Course Code | Course | Required |
| Credits | Course | Between 1 and 10 |
| Enrollment Date | Enrollment | Required |
| Grade | Enrollment | A, A+, B+, B, C+, C, D, or F |
| Enrollment Status | Enrollment | E (Enrolled), C (Completed), D (Dropped) |
| Address Type | Address | HOME, MAIL, or TEMP |

### UI Features
- **Status Criticality Coloring**: Active=Green, Inactive=Red, Graduated=Yellow
- **Enrollment Status Coloring**: Enrolled=Yellow, Completed=Green, Dropped=Red
- **Value Help Dropdowns**: Department and Course pickers with details
- **Fuzzy Search**: On name, registration number, email, course title
- **Filter Bar**: Filter by name, reg no, status, department
- **Object Page Sections**: Student Info, Department, Addresses table, Enrollments table, Admin Data
- **Sub-Object Pages**: Navigate into Address or Enrollment for detail editing
- **Course Object Page**: Shows enrolled students in a table

### Custom Actions
- `changeStudentStatus` — Change a student's status programmatically

---

## Running the Application

```bash
npm install          # Install dependencies
cds watch            # Start with live reload (http://localhost:4004)
```

### URLs
| URL | Description |
|-----|-------------|
| http://localhost:4004/students/webapp/index.html | Student Management UI |
| http://localhost:4004/student/ | OData service endpoint |
| http://localhost:4004/student/$metadata | OData metadata |
| http://localhost:4004/student/Students | Students API |
| http://localhost:4004/student/Courses | Courses API |
| http://localhost:4004/student/Departments | Departments API |

### Sample Data
Pre-loaded via `db/data/seed-data.cds`:
- **5 Departments**: CS, ME, EE, MBA, MATH
- **10 Courses**: Across all departments (1–4 credits each)
- **3 Students**: With addresses and enrollments pre-filled

---

## ABAP RAP Implementation in ADT

For deployment to SAP BTP ABAP Environment, create objects in this order in ADT (Eclipse):

1. **Database Tables**: `ZSTUDENTSS`, `ZSTUDENTSS_D`, `ZDEPARTMENTS`, `ZCOURSES`, `ZCOURSES_D`, `ZADDRESSES`, `ZADDRESSES_D`, `ZENROLLMENTS`, `ZENROLLMENTS_D`
2. **Interface CDS Views**: `ZI_DEPARTMENT`, `ZI_COURSE`, `ZI_STUDENT`, `ZI_ADDRESS`, `ZI_ENROLLMENT`
3. **Behavior Definition**: `ZI_STUDENT` (includes Address + Enrollment child behaviors)
4. **Behavior Implementation**: `ZBP_I_STUDENT` (global + local handler classes)
5. **Projection Views**: `ZC_DEPARTMENT`, `ZC_COURSE`, `ZC_STUDENT`, `ZC_ADDRESS`, `ZC_ENROLLMENT`
6. **Behavior Projection**: `ZC_STUDENT` (includes child projections)
7. **Metadata Extension**: `ZC_STUDENT`
8. **Service Definition**: `ZUI_STUDENT` (exposes all projection views)
9. **Service Binding**: `ZUI_STUDENT_O4` (OData V4 UI, then Publish)

---

## Troubleshooting

| Issue | Solution |
|-------|---------|
| `cds watch` fails | Run `npm install` first |
| No data on first load | Seed data loads automatically from `db/data/seed-data.cds` |
| Draft errors | Clear browser cache or use incognito mode |
| Port 4004 in use | `set PORT=4005` then `cds watch` |
| Department dropdown empty | Check that seed data loaded — try `http://localhost:4004/student/Departments` |
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
