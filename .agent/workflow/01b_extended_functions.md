# Extended Functions — 3 New CRUD Modules
## VetCare Pro: Veterinary Clinic Management System

> **Status:** ✅ APPROVED — Integrated into Requirements  
> **Last Updated:** 2026-11-04  
> **Rationale:** These 3 modules fill logical gaps identified in existing sequence diagrams and database schema.

---

## Why These 3 Modules? — Gap Analysis

| Gap Found In | Problem | New Module to Fix It |
|-------------|---------|---------------------|
| `SlotAvailabilityService` in D-04 calls vet schedule but no module manages it | Cannot determine available booking slots without vet working hours data | **Module I — Vet Schedule Management** |
| `ServiceCatalogRepository` in D-06 fetches prices but no admin UI manages the catalog | Invoice auto-generation (FR-32) requires a service price list that someone must maintain | **Module J — Service Catalog Management** |
| `inventory` table exists in ERD, FR-30/FR-31 reference stock but no stock-in flow | Medicines run out with no way to record restocking → alerts are meaningless | **Module K — Inventory & Stock Management** |

---

## Module I — Veterinarian Schedule & Leave Management

### Business Rationale
The appointment booking flow (UC-03) calls `SlotAvailabilityService.getAvailableSlots(vetId, date)`, which must query a **working hours table** to know when a vet is available. Without this module, the system cannot distinguish between a vet being free vs. simply having no appointments booked — a vet might be on leave or only works certain days.

### Functional Requirements

| ID | Requirement Description | Actor | Priority | MoSCoW |
|----|------------------------|-------|----------|--------|
| **FR-41** | The system shall allow Admin/Manager to define a veterinarian's **weekly working schedule** (day of week, start time, end time, break periods). | Admin, Manager | Must Have | 🔴 Must |
| **FR-42** | The system shall allow Admin/Manager to create **leave records** for a veterinarian (leave type: sick/annual/emergency, date range, reason). | Admin, Manager | Must Have | 🔴 Must |
| **FR-43** | The system shall allow Admin/Manager to view, update, and delete working schedule entries and leave records per vet. | Admin, Manager | Must Have | 🔴 Must |
| **FR-44** | The system shall allow Veterinarians to view their own schedule, upcoming appointments, and approved leave in a **weekly calendar view**. | Veterinarian | Should Have | 🟠 Should |
| **FR-45** | The slot availability check during appointment booking (FR-11) shall **automatically exclude** time slots that fall outside the vet's working hours or during approved leave periods. | System | Must Have | 🔴 Must |

### New Database Tables

```
VET_WORKING_HOURS
├── id (PK)
├── vet_id (FK → veterinarians.id)
├── day_of_week (ENUM: MON,TUE,WED,THU,FRI,SAT,SUN)
├── start_time (TIME)
├── end_time (TIME)
├── slot_duration_minutes (INT, default 30)
└── is_active (BOOLEAN)

VET_LEAVES
├── id (PK)
├── vet_id (FK → veterinarians.id)
├── leave_type (ENUM: SICK, ANNUAL, EMERGENCY, OTHER)
├── start_date (DATE)
├── end_date (DATE)
├── reason (TEXT)
├── status (ENUM: PENDING, APPROVED, REJECTED)
└── approved_by (FK → users.id)
```

### Connections to Existing System

```
FR-41/FR-42 (Schedule Data)
        ↓ feeds into
SlotAvailabilityService.getAvailableSlots()  ← UC-03 D-04 Sequence Diagram
        ↓ determines
FR-11 (Real-time slot display during booking)
        ↓ prevents
E1 in UC-03 (Slot conflict / race condition)
```

### CRUD Operations Summary

| Operation | Endpoint | Actor |
|-----------|----------|-------|
| **C** — Create working hours | `POST /vets/{id}/schedule` | Admin |
| **R** — View vet schedule | `GET /vets/{id}/schedule` | Admin, Vet |
| **U** — Update working hours | `PUT /vets/{id}/schedule/{dayId}` | Admin |
| **D** — Remove a schedule entry | `DELETE /vets/{id}/schedule/{dayId}` | Admin |
| **C** — Create leave record | `POST /vets/{id}/leaves` | Admin |
| **R** — List leave records | `GET /vets/{id}/leaves` | Admin, Vet |
| **U** — Update leave status | `PUT /vets/{id}/leaves/{leaveId}` | Admin |
| **D** — Cancel leave | `DELETE /vets/{id}/leaves/{leaveId}` | Admin |

---

## Module J — Clinic Service Catalog Management

### Business Rationale
The invoice auto-generation in UC-07 (D-06 Sequence Diagram, step: `findServicePrice(CONSULTATION)`) depends on a **service price catalog** to know what to charge. Currently the `SERVICES` table exists in the ERD but there is no admin interface to create/modify services. Without this module, a clinic cannot add new service types (e.g., "X-Ray", "Dental Cleaning", "Blood Panel") or adjust prices — requiring direct database edits.

### Functional Requirements

| ID | Requirement Description | Actor | Priority | MoSCoW |
|----|------------------------|-------|----------|--------|
| **FR-46** | The system shall allow Admin/Manager to **create a new clinic service** with: name, category (Consultation / Lab / Procedure / Grooming / Other), description, standard price, estimated duration (minutes), and active status. | Admin, Manager | Must Have | 🔴 Must |
| **FR-47** | The system shall allow Admin/Manager to **view and search** the full service catalog (filter by category, active/inactive, price range). | Admin, Manager, Receptionist | Must Have | 🔴 Must |
| **FR-48** | The system shall allow Admin/Manager to **update** service details including name, category, description, and price. Price changes shall not retroactively affect already-issued invoices. | Admin, Manager | Must Have | 🔴 Must |
| **FR-49** | The system shall allow Admin/Manager to **deactivate (soft-delete)** a service so it no longer appears in booking or invoicing but its historical data is preserved. | Admin | Should Have | 🟠 Should |
| **FR-50** | The system shall allow Receptionists to **view the active service catalog** when manually adding items to an invoice (FR-33). | Receptionist | Must Have | 🔴 Must |
| **FR-51** | The system shall allow Pet Owners to view a **public-facing list of clinic services and estimated prices** on their portal. | Pet Owner | Could Have | 🟡 Could |

### New Database Column / Constraint

The existing `SERVICES` table (already in ERD) gains these additional constraints:
```
SERVICES (enhanced)
├── id (PK)
├── name (VARCHAR, UNIQUE)
├── category (ENUM: CONSULTATION, LAB_TEST, PROCEDURE, VACCINATION_SERVICE, GROOMING, OTHER)
├── description (TEXT)
├── price (DECIMAL 10,2, CHECK price >= 0)
├── duration_minutes (INT)
├── is_active (BOOLEAN, DEFAULT TRUE)
└── updated_at (DATETIME)

SERVICE_PRICE_HISTORY  ← NEW: audit trail for price changes
├── id (PK)
├── service_id (FK → services.id)
├── old_price (DECIMAL)
├── new_price (DECIMAL)
├── changed_by (FK → users.id)
└── changed_at (DATETIME)
```

### Connections to Existing System

```
FR-46 (Service created with price)
        ↓
FR-47/FR-50 (Receptionist selects from catalog)
        ↓
FR-32 (Invoice auto-generated from services rendered in visit)
        ↓
FR-33 (Receptionist manually adds services to invoice)
        ↓
FR-38 (Monthly revenue report grouped by service.category)
```

### CRUD Operations Summary

| Operation | Endpoint | Actor |
|-----------|----------|-------|
| **C** — Create service | `POST /services` | Admin, Manager |
| **R** — List all services | `GET /services` | Admin, Manager, Receptionist |
| **R** — Get service by ID | `GET /services/{id}` | All |
| **U** — Update service | `PUT /services/{id}` | Admin, Manager |
| **D** — Deactivate service | `DELETE /services/{id}` (soft delete) | Admin |
| **R** — View price history | `GET /services/{id}/price-history` | Admin, Manager |

---

## Module K — Medicine Inventory & Stock Management

### Business Rationale
The current system tracks `stock_quantity` in the `MEDICINES` table and FR-31 sends low-stock alerts. But there is **no mechanism to replenish stock** (record incoming stock from supplier), **no expiry date tracking**, and **no stock adjustment records** (for damaged/expired/returned medicines). Without this, inventory figures become inaccurate quickly — prescriptions are dispensed but stock numbers are wrong.

### Functional Requirements

| ID | Requirement Description | Actor | Priority | MoSCoW |
|----|------------------------|-------|----------|--------|
| **FR-52** | The system shall allow Admin/Pharmacy Staff to **add new medicine entries** to the catalog (name, active ingredient, dosage form, unit, unit price, minimum stock threshold). | Admin, Pharmacy | Must Have | 🔴 Must |
| **FR-53** | The system shall allow Admin/Pharmacy Staff to **record stock-in transactions** (receive new stock): medicine, quantity received, supplier, expiry date, batch number, unit cost. Each stock-in increases `stock_quantity`. | Admin, Pharmacy | Must Have | 🔴 Must |
| **FR-54** | The system shall allow Admin/Pharmacy Staff to view the **current inventory dashboard**: all medicines, current stock, expiry dates, stock status (OK / Low / Critical / Out), and last restocked date. | Admin, Pharmacy | Must Have | 🔴 Must |
| **FR-55** | The system shall allow Admin/Pharmacy Staff to **record stock adjustments** with reason codes: EXPIRED, DAMAGED, RETURNED_TO_SUPPLIER, CORRECTION. Each adjustment decreases/adjusts `stock_quantity` and logs the reason. | Admin, Pharmacy | Should Have | 🟠 Should |
| **FR-56** | The system shall **automatically deduct stock** from inventory when a prescription is marked as dispensed (FR-29), creating a stock-out transaction record. | System | Must Have | 🔴 Must |
| **FR-57** | The system shall display an **expiry warning** for medicines expiring within 30 days, and automatically flag medicines past their expiry date as EXPIRED status. | System | Should Have | 🟠 Should |

### New Database Tables

```
STOCK_TRANSACTIONS  ← NEW: complete stock movement audit
├── id (PK)
├── medicine_id (FK → medicines.id)
├── transaction_type (ENUM: STOCK_IN, DISPENSED, ADJUSTMENT_EXPIRED,
│                           ADJUSTMENT_DAMAGED, ADJUSTMENT_RETURNED, CORRECTION)
├── quantity_change (INT)          -- positive = in, negative = out
├── quantity_after (INT)           -- snapshot of stock after transaction
├── reference_id (BIGINT, nullable) -- FK to prescription_items.id or purchase_order.id
├── batch_number (VARCHAR)
├── expiry_date (DATE)
├── supplier_name (VARCHAR)
├── unit_cost (DECIMAL)
├── notes (TEXT)
├── performed_by (FK → users.id)
└── transaction_date (DATETIME)

MEDICINES (enhanced additions to existing table)
├── ... existing columns ...
├── expiry_date (DATE)             ← NEW
├── last_restocked_at (DATETIME)   ← NEW
└── supplier_name (VARCHAR)        ← NEW
```

### Connections to Existing System

```
FR-52 (Medicine added to catalog)
        ↓
FR-53 (Stock received → STOCK_TRANSACTIONS record created)
        ↓
FR-30 (Medicine catalog used in prescription creation)
        ↓
FR-28/FR-29 (Prescription dispensed → FR-56 auto-deducts stock)
        ↓ STOCK_TRANSACTIONS: DISPENSED entry
FR-31 (Low-stock alert triggered when stock_quantity < min_threshold)
        ↓
FR-57 (Expiry warning → flag EXPIRED in inventory dashboard)
        ↓
FR-55 (Manual adjustment for expired stock)
```

### CRUD Operations Summary

| Operation | Endpoint | Actor |
|-----------|----------|-------|
| **C** — Add medicine to catalog | `POST /medicines` | Admin |
| **R** — List all medicines | `GET /medicines` | Admin, Vet, Pharmacy |
| **R** — Get medicine detail | `GET /medicines/{id}` | Admin, Vet, Pharmacy |
| **U** — Update medicine info | `PUT /medicines/{id}` | Admin |
| **D** — Deactivate medicine | `DELETE /medicines/{id}` | Admin |
| **C** — Record stock-in | `POST /inventory/stock-in` | Admin, Pharmacy |
| **C** — Record adjustment | `POST /inventory/adjustments` | Admin, Pharmacy |
| **R** — Inventory dashboard | `GET /inventory` | Admin, Pharmacy |
| **R** — Transaction history | `GET /inventory/{medicineId}/transactions` | Admin, Pharmacy |

---

## Updated Requirements Count

| Version | FR Count | New Modules |
|---------|----------|-------------|
| Original (v1) | FR-01 → FR-40 (40 FRs) | A through H |
| **Extended (v2)** | **FR-01 → FR-57 (57 FRs)** | **+ Module I, J, K** |

### New MoSCoW Summary (Extended)

| MoSCoW | Original | Added | Total |
|--------|----------|-------|-------|
| 🔴 Must Have | 26 | 10 | **36** |
| 🟠 Should Have | 12 | 4 | **16** |
| 🟡 Could Have | 2 | 1 | **3** |
| **Total** | **40** | **17** | **57** |

---

## Integration Impact on Existing Artifacts

| Artifact | What Changes |
|----------|-------------|
| `01_requirements.md` | Append FR-41 → FR-57 to Section 2; update MoSCoW table |
| `02_use_cases.md` | Add UC-08 (Manage Vet Schedule), UC-09 (Manage Services), UC-10 (Manage Inventory) |
| `03_uml_diagrams.md` | Add `VetWorkingHours`, `VetLeave`, `StockTransaction`, `ServicePriceHistory` to Class & ERD diagrams |
| `04_database_design.md` | Add 4 new tables: `vet_working_hours`, `vet_leaves`, `stock_transactions`, `service_price_history` |
| Java Demo Scope | Module J (Service Catalog) is recommended to add to demo D-06 (auto-invoice now pulls real service prices) |

---

*Cross-reference: → [`01_requirements.md`](./01_requirements.md) | [`02_use_cases.md`](./02_use_cases.md) | [`03_uml_diagrams.md`](./03_uml_diagrams.md)*

