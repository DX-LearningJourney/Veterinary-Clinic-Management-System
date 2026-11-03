# Workflow Document 01 — Requirements Identification & Specification
## VetCare Pro: Veterinary Clinic Management System

> **Status:** 🟡 DRAFT — Under Review  
> **Last Updated:** 2026-11-04  
> **Purpose:** This document is the working specification board for the RAD team to collaboratively define, refine, and finalize all system requirements before Java implementation begins.

---

## 📌 HOW TO USE THIS DOCUMENT

This is your **team's collaborative requirements workspace**. Before writing a single line of Java code:
1. Review the **Current State** analysis (Section 1)
2. Validate all **Functional Requirements** (Section 2) — ensure no gaps
3. Confirm **Non-Functional Requirements** (Section 3)
4. Agree on **MoSCoW prioritization** (Section 4)
5. Sign off → move to `02_use_cases.md`

---

## Section 1 — Survey & Description of Current State

### 1.1 Business Context

A typical small-to-medium veterinary clinic in Vietnam operates as follows:

**Reception & Appointments:**
- Customers call or walk in to book appointments
- Receptionist writes bookings in a paper logbook or basic spreadsheet (Excel)
- No online booking; missed calls = lost appointments
- Schedule conflicts happen frequently when multiple staff share a paper calendar

**Clinical Examination:**
- Veterinarian uses handwritten notes on paper forms
- Patient history must be manually searched through paper files
- No standard format (some vets use SOAP, some use free text)
- Lab test results received as paper printouts, often lost

**Vaccination Tracking:**
- Vaccination records kept in a paper "vaccine book" given to pet owners
- Clinic has no systematic record of which pets need follow-up shots
- No automated reminders — owners must remember on their own
- High rate of missed/late vaccinations

**Pharmacy & Prescriptions:**
- Prescriptions written by hand on paper slips
- Pharmacist/nurse manually checks stock availability
- No system to track which medicines were dispensed per patient
- Inventory counted manually at end of month — frequent stockouts

**Billing:**
- Receptionist manually calculates the bill from a price list
- Handwritten receipts with no digital record
- No way to track outstanding payments or payment history

**Management & Reporting:**
- Clinic owner has no real-time visibility into revenue or patient counts
- Monthly reports are compiled manually from spreadsheets — time-consuming
- No data on popular services, peak hours, or veterinarian workload

### 1.2 Stakeholders Identified

| Stakeholder | Type | Pain Points |
|-------------|------|-------------|
| **Pet Owner** | External (Primary User) | Hard to book online, no reminders, can't view pet history |
| **Veterinarian** | Internal (Primary User) | No digital records, slow access to patient history |
| **Receptionist** | Internal (Primary User) | Manual scheduling, prone to double-booking, slow check-in |
| **Clinic Manager** | Internal (Decision Maker) | No real-time dashboard, manual monthly reports |
| **Pharmacy Staff** | Internal (Secondary User) | No digital prescription, manual stock counting |
| **System Admin** | Internal (Technical) | No centralized system, security concerns |

### 1.3 Problems & Limitations of Current State

| # | Problem | Impact | Severity |
|---|---------|--------|----------|
| P-01 | No online appointment booking | Lost customers, missed revenue | 🔴 High |
| P-02 | Paper medical records — easy to lose/damage | Clinical errors, liability risk | 🔴 High |
| P-03 | No vaccination reminder system | Poor follow-up, pet health risk | 🔴 High |
| P-04 | Manual billing — error-prone | Revenue loss, customer disputes | 🟠 Medium |
| P-05 | No inventory management | Stockouts, waste | 🟠 Medium |
| P-06 | No management dashboard | Slow decision-making | 🟠 Medium |
| P-07 | No role-based access control | Security/privacy risk | 🔴 High |
| P-08 | No digital prescription tracking | Dispensing errors | 🟠 Medium |

---

## Section 2 — Functional Requirements

### 2.1 Requirement Identification Rules
- Each requirement is assigned a unique ID: **FR-XX**
- Each requirement has: Description, Actor, Priority (see Section 4), Rationale
- Requirements are grouped by functional module

---

### 2.2 Functional Requirements List

#### Module A — User & Authentication Management

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-01** | The system shall allow users to register an account with name, email, phone number, and password. | Pet Owner | Must Have |
| **FR-02** | The system shall authenticate users via email and password with session/JWT management. | All Users | Must Have |
| **FR-03** | The system shall support role-based access control (RBAC) with roles: Admin, Veterinarian, Receptionist, Pet Owner. | Admin | Must Have |
| **FR-04** | The system shall allow Admin to create, update, deactivate, and delete user accounts. | Admin | Must Have |
| **FR-05** | The system shall allow users to reset their password via email verification link. | All Users | Should Have |

---

#### Module B — Pet & Owner Profile Management

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-06** | The system shall allow Pet Owners to register one or more pet profiles (name, species, breed, date of birth, weight, gender, microchip ID, photo). | Pet Owner | Must Have |
| **FR-07** | The system shall allow authorized staff to view and update pet profiles. | Receptionist, Vet | Must Have |
| **FR-08** | The system shall record and display a pet's known allergies and medical conditions as a prominent warning. | Veterinarian | Must Have |
| **FR-09** | The system shall maintain a complete, chronological medical history for each pet across all visits. | Veterinarian, Pet Owner | Must Have |

---

#### Module C — Appointment Management

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-10** | The system shall allow Pet Owners to book an appointment online by selecting a date, time slot, veterinarian, and reason for visit. | Pet Owner | Must Have |
| **FR-11** | The system shall display real-time availability of veterinarians and time slots when booking. | Pet Owner | Must Have |
| **FR-12** | The system shall allow Pet Owners to reschedule or cancel their appointments online. | Pet Owner | Must Have |
| **FR-13** | The system shall allow Receptionists to create, modify, and cancel appointments on behalf of customers. | Receptionist | Must Have |
| **FR-14** | The system shall send automated email/SMS confirmation upon appointment booking. | System | Should Have |
| **FR-15** | The system shall send automated reminder notifications 24 hours before an appointment. | System | Should Have |
| **FR-16** | The system shall provide a daily/weekly calendar view of all appointments for clinic staff. | Receptionist, Vet | Must Have |
| **FR-17** | The system shall support appointment status tracking: Pending → Confirmed → In Progress → Completed / Cancelled. | All Staff | Must Have |

---

#### Module D — Medical Examination & Records (EHR)

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-18** | The system shall allow Veterinarians to create a medical record (SOAP format: Subjective, Objective, Assessment, Plan) for each visit. | Veterinarian | Must Have |
| **FR-19** | The system shall allow Veterinarians to record diagnoses using a structured format (diagnosis name, code, severity, notes). | Veterinarian | Must Have |
| **FR-20** | The system shall allow Veterinarians to order laboratory tests and attach results to the medical record. | Veterinarian | Should Have |
| **FR-21** | The system shall allow Veterinarians to record the pet's vital signs (weight, temperature, heart rate, etc.) per visit. | Veterinarian | Must Have |
| **FR-22** | The system shall allow Pet Owners to view their pet's medical records (read-only access). | Pet Owner | Should Have |

---

#### Module E — Vaccination Management

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-23** | The system shall maintain a catalog of available vaccines with name, description, recommended schedule, and manufacturer. | Admin, Vet | Must Have |
| **FR-24** | The system shall allow Veterinarians to record a vaccination event (vaccine, dose, batch number, administration date, next due date). | Veterinarian | Must Have |
| **FR-25** | The system shall generate and display a complete vaccination history per pet. | Veterinarian, Pet Owner | Must Have |
| **FR-26** | The system shall automatically send reminder notifications to Pet Owners when a vaccination due date is approaching (7 days prior). | System | Must Have |
| **FR-27** | The system shall allow generation and printing of a vaccination certificate per pet. | Veterinarian, Receptionist | Should Have |

---

#### Module F — Prescription & Pharmacy

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-28** | The system shall allow Veterinarians to create digital prescriptions linked to a medical record (medicine, dosage, frequency, duration, instructions). | Veterinarian | Must Have |
| **FR-29** | The system shall allow Pharmacy Staff to mark a prescription as dispensed and update inventory accordingly. | Pharmacy Staff | Should Have |
| **FR-30** | The system shall maintain a medicine catalog with name, active ingredient, unit, unit price, and stock level. | Admin, Pharmacy | Must Have |
| **FR-31** | The system shall alert Pharmacy Staff when medicine stock falls below a defined threshold. | System | Should Have |

---

#### Module G — Billing & Invoicing

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-32** | The system shall automatically generate an invoice upon completion of a visit, based on services rendered and medicines dispensed. | System | Must Have |
| **FR-33** | The system shall allow Receptionists to add, modify, or remove invoice line items before finalizing. | Receptionist | Must Have |
| **FR-34** | The system shall support multiple payment methods: cash, bank transfer, card. | Receptionist | Should Have |
| **FR-35** | The system shall track payment status per invoice: Unpaid / Paid / Partially Paid. | Receptionist | Must Have |
| **FR-36** | The system shall allow printing or emailing of invoices to Pet Owners. | Receptionist | Should Have |

---

#### Module H — Reporting & Dashboard

| ID | Requirement Description | Actor | Priority |
|----|------------------------|-------|----------|
| **FR-37** | The system shall provide a management dashboard showing: today's appointments, revenue summary, patient count, and low-stock alerts. | Manager | Must Have |
| **FR-38** | The system shall generate a monthly revenue report broken down by service category. | Manager | Should Have |
| **FR-39** | The system shall generate an appointment statistics report (by doctor, by date range, by status). | Manager | Should Have |
| **FR-40** | The system shall maintain an audit log of all critical actions (login, record creation/modification, prescription issuance). | Admin | Could Have |

---

### 2.3 Summary Count

| Module | FR Count |
|--------|----------|
| A — User & Auth | FR-01 to FR-05 (5) |
| B — Pet & Owner Profile | FR-06 to FR-09 (4) |
| C — Appointment | FR-10 to FR-17 (8) |
| D — Medical Records (EHR) | FR-18 to FR-22 (5) |
| E — Vaccination | FR-23 to FR-27 (5) |
| F — Prescription & Pharmacy | FR-28 to FR-31 (4) |
| G — Billing & Invoicing | FR-32 to FR-36 (5) |
| H — Reporting & Dashboard | FR-37 to FR-40 (4) |
| **TOTAL** | **40 Functional Requirements** |

---

## Section 3 — Non-Functional Requirements

| ID | Category | Requirement | Metric / Target |
|----|----------|-------------|----------------|
| **NFR-01** | **Performance** | Page load time for any screen must be < 3 seconds under normal load | < 3s at 95th percentile |
| **NFR-02** | **Performance** | The appointment booking transaction must complete within 2 seconds | < 2s end-to-end |
| **NFR-03** | **Scalability** | System must support at least 500 concurrent users without degradation | 500 concurrent sessions |
| **NFR-04** | **Scalability** | Database must handle at least 100,000 medical records without performance loss | Verified via load test |
| **NFR-05** | **Security** | All passwords must be stored as bcrypt-hashed values (minimum cost factor 10) | bcrypt, factor ≥ 10 |
| **NFR-06** | **Security** | API endpoints must require valid JWT token; token expiry 60 minutes | JWT, 60-min TTL |
| **NFR-07** | **Security** | Sensitive medical data must be encrypted at rest (AES-256) | AES-256 |
| **NFR-08** | **Security** | System must enforce RBAC — users can only access data within their role | Zero privilege escalation |
| **NFR-09** | **Usability** | The UI must be learnable by a non-technical receptionist within 1 hour of training | ≤ 60 min onboarding |
| **NFR-10** | **Usability** | Appointment booking must require no more than 5 user interactions to complete | ≤ 5 clicks |
| **NFR-11** | **Reliability** | System uptime must be ≥ 99.5% during clinic operating hours (7:00–21:00) | 99.5% uptime |
| **NFR-12** | **Reliability** | Automated database backup must occur daily; recovery point objective (RPO) ≤ 24h | Daily backup |
| **NFR-13** | **Maintainability** | Codebase must follow layered architecture (Controller → Service → Repository) | Code review checklist |
| **NFR-14** | **Maintainability** | All API endpoints must be documented (Swagger/OpenAPI 3.0) | 100% API doc coverage |
| **NFR-15** | **Compatibility** | Web UI must be compatible with Chrome 110+, Firefox 110+, Edge 110+ | Cross-browser tested |
| **NFR-16** | **Data Integrity** | Foreign key constraints must be enforced at the database level | DB schema enforced |
| **NFR-17** | **Compliance** | System must comply with Vietnamese personal data protection regulations | Data privacy audit |
| **NFR-18** | **Portability** | Application must be deployable via Docker containers | Docker compose file |

---

## Section 4 — MoSCoW Prioritization Table

### 4.1 Functional Requirements Prioritization

| Priority | Color | Definition |
|----------|-------|-----------|
| **Must Have** | 🔴 | Critical for system to function; demo blocker if missing |
| **Should Have** | 🟠 | Important, adds significant value; implement after Must Haves |
| **Could Have** | 🟡 | Nice to have; implement if time permits |
| **Won't Have (this phase)** | ⚪ | Explicitly deferred to Phase 2 |

#### Functional Requirements — MoSCoW

| ID | Description | MoSCoW | Sprint |
|----|-------------|--------|--------|
| FR-01 | User Registration | 🔴 Must | S1 |
| FR-02 | User Authentication (Login/Logout) | 🔴 Must | S1 |
| FR-03 | Role-Based Access Control (RBAC) | 🔴 Must | S1 |
| FR-04 | Admin User Management | 🔴 Must | S1 |
| FR-05 | Password Reset via Email | 🟠 Should | S3 |
| FR-06 | Pet Profile Registration | 🔴 Must | S1 |
| FR-07 | Staff View/Update Pet Profile | 🔴 Must | S1 |
| FR-08 | Allergy & Condition Alerts | 🔴 Must | S2 |
| FR-09 | Pet Medical History View | 🔴 Must | S2 |
| FR-10 | Online Appointment Booking | 🔴 Must | S2 |
| FR-11 | Real-time Slot Availability | 🔴 Must | S2 |
| FR-12 | Appointment Reschedule/Cancel | 🔴 Must | S2 |
| FR-13 | Staff Appointment Management | 🔴 Must | S2 |
| FR-14 | Booking Confirmation Notification | 🟠 Should | S3 |
| FR-15 | 24h Appointment Reminder | 🟠 Should | S3 |
| FR-16 | Calendar View for Staff | 🔴 Must | S2 |
| FR-17 | Appointment Status Tracking | 🔴 Must | S2 |
| FR-18 | SOAP Medical Record Creation | 🔴 Must | S2 |
| FR-19 | Structured Diagnosis Recording | 🔴 Must | S2 |
| FR-20 | Lab Test Orders & Results | 🟠 Should | S3 |
| FR-21 | Vital Signs Recording | 🔴 Must | S2 |
| FR-22 | Pet Owner View Medical Records | 🟠 Should | S3 |
| FR-23 | Vaccine Catalog Management | 🔴 Must | S2 |
| FR-24 | Vaccination Event Recording | 🔴 Must | S2 |
| FR-25 | Vaccination History Per Pet | 🔴 Must | S2 |
| FR-26 | Vaccination Due Date Reminders | 🔴 Must | S3 |
| FR-27 | Vaccination Certificate Generation | 🟠 Should | S3 |
| FR-28 | Digital Prescription Creation | 🔴 Must | S2 |
| FR-29 | Prescription Dispensing & Inventory Update | 🟠 Should | S3 |
| FR-30 | Medicine Catalog Management | 🔴 Must | S2 |
| FR-31 | Low-Stock Alert | 🟠 Should | S3 |
| FR-32 | Auto Invoice Generation | 🔴 Must | S3 |
| FR-33 | Invoice Line Item Editing | 🔴 Must | S3 |
| FR-34 | Multiple Payment Methods | 🟠 Should | S3 |
| FR-35 | Payment Status Tracking | 🔴 Must | S3 |
| FR-36 | Invoice Print/Email | 🟠 Should | S4 |
| FR-37 | Management Dashboard | 🔴 Must | S3 |
| FR-38 | Monthly Revenue Report | 🟠 Should | S4 |
| FR-39 | Appointment Statistics Report | 🟠 Should | S4 |
| FR-40 | Audit Logs | 🟡 Could | S4 |

#### Summary by Priority

| MoSCoW | Count | % |
|--------|-------|---|
| 🔴 Must Have | 26 | 65% |
| 🟠 Should Have | 12 | 30% |
| 🟡 Could Have | 2 | 5% |
| ⚪ Won't Have | 0 | — |

### 4.2 Non-Functional Requirements Prioritization

| ID | NFR | MoSCoW |
|----|-----|--------|
| NFR-01 | Page load < 3s | 🔴 Must |
| NFR-02 | Booking transaction < 2s | 🔴 Must |
| NFR-03 | 500 concurrent users | 🟠 Should |
| NFR-04 | 100K records performance | 🟠 Should |
| NFR-05 | bcrypt password storage | 🔴 Must |
| NFR-06 | JWT authentication | 🔴 Must |
| NFR-07 | Data encryption at rest | 🟡 Could |
| NFR-08 | RBAC enforcement | 🔴 Must |
| NFR-09 | 1-hour receptionist onboarding | 🟠 Should |
| NFR-10 | ≤ 5 clicks for booking | 🔴 Must |
| NFR-11 | 99.5% uptime | 🟠 Should |
| NFR-12 | Daily DB backup | 🟠 Should |
| NFR-13 | Layered architecture | 🔴 Must |
| NFR-14 | Swagger API docs | 🟠 Should |
| NFR-15 | Cross-browser compatibility | 🔴 Must |
| NFR-16 | DB-level FK constraints | 🔴 Must |
| NFR-17 | Data privacy compliance | 🟠 Should |
| NFR-18 | Docker deployment | 🟡 Could |

---

## Section 5 — Java Demo Scope (Confirmed Features for Live Demo)

Based on the MoSCoW analysis, the following 5 features are confirmed for the **Java live demo** (in scope for Sprint 1–3):

| Demo # | Feature | FRs Covered | Module |
|--------|---------|-------------|--------|
| **D-01** | User Login & Role-Based Access | FR-01, FR-02, FR-03 | Auth |
| **D-02** | Pet Profile Management (CRUD) | FR-06, FR-07, FR-08 | Pet |
| **D-03** | Appointment Booking & Management | FR-10, FR-11, FR-12, FR-13, FR-16, FR-17 | Appointment |
| **D-04** | Medical Record & Vaccination Entry | FR-18, FR-19, FR-21, FR-23, FR-24, FR-25 | EHR + Vaccination |
| **D-05** | Invoice Generation & Payment Tracking | FR-32, FR-33, FR-35 | Billing |

---

## Section 6 — Open Questions & Team Discussion Points

> **❓ Use this section to document team decisions before finalizing requirements**

| # | Question | Options | Decision | Decided By | Date |
|---|----------|---------|----------|-----------|------|
| Q-01 | What Java UI for demo: Swing, JavaFX, or Spring Web + Thymeleaf? | Swing / JavaFX / Spring Web | ✅ **Spring Boot + Thymeleaf + Bootstrap 5** | Team | 2026-11-04 |
| Q-02 | Database: MySQL or H2 (embedded for demo)? | MySQL / H2 / PostgreSQL | ✅ **MySQL 8.x** (matches production design) | Team | 2026-11-04 |
| Q-03 | Do we implement email notifications for demo? | Yes (MockMail) / No (flag in DB) | ✅ **Flag in DB + console log** (no live SMTP needed) | Team | 2026-11-04 |
| Q-04 | Do we scope Pharmacy/Inventory in Java demo? | Full / Simplified / Skip | ✅ **Simplified** (catalog view + prescription link) | Team | 2026-11-04 |
| Q-05 | Which 3 sequence diagrams to draw? | Booking / EHR / Vaccination / Billing | ✅ **UC-03 Book Appointment + UC-04 Medical Examination + UC-07 Payment** | Team | 2026-11-04 |
| Q-06 | Use PlantUML or draw.io for UML diagrams? | PlantUML / draw.io / StarUML | ✅ **Mermaid** (renders in Markdown, version-controllable in Git) | Team | 2026-11-04 |
| Q-07 | Figma: who owns and shares the file? | Team Member 4 | ✅ **Team Member 4 owns; share link in figma/figma-export-links.md** | Team | 2026-11-04 |

---

## Section 7 — Approval Checklist

Before proceeding to `02_use_cases.md` (Use Case Specification):

- [ ] All team members have reviewed FR-01 through FR-40
- [ ] MoSCoW priorities agreed upon
- [ ] Java demo scope (D-01 to D-05) confirmed
- [ ] Open questions Q-01 through Q-07 answered
- [ ] Technology stack finalized (Java framework, DB, UML tool)
- [ ] Task assignments distributed (see Report Appendix)

**Sign-off:** ___________________________________ Date: ___________

---

*Next: → [`02_use_cases.md`](./02_use_cases.md) — Detailed Use Case Specifications*

