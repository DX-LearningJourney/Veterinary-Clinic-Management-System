# 🐾 VetCare Pro — Veterinary Clinic Management System

> **Course:** Requirements Analysis & Design (RAD) — Software Engineering  
> **Academic Year:** 2025–2026  
> **Project Type:** Full-cycle Software Analysis, Design & Prototype  

---

## 📋 Table of Contents

1. [Project Overview](#1-project-overview)
2. [Rationale & Objectives](#2-rationale--objectives)
3. [System Scope](#3-system-scope)
4. [Key Features](#4-key-features)
5. [Stakeholders](#5-stakeholders)
6. [Technology Stack](#6-technology-stack)
7. [Project Structure](#7-project-structure)
8. [UML Artifacts](#8-uml-artifacts)
9. [Database Design](#9-database-design)
10. [Prototype & Demo](#10-prototype--demo)
11. [Team Members](#11-team-members)
12. [References](#12-references)

---

## 1. Project Overview

**VetCare Pro** is a comprehensive web-based **Veterinary Clinic Management System** designed to digitize and streamline the end-to-end operations of a modern animal healthcare clinic. The system replaces manual, paper-based workflows with an integrated digital platform that serves pet owners, veterinary staff, and clinic administrators.

The platform covers the complete patient journey — from online appointment booking and veterinary consultation to electronic medical records, vaccination scheduling, prescription management, billing, and operational reporting.

---

## 2. Rationale & Objectives

### 2.1 Rationale

The veterinary care industry is experiencing rapid growth driven by increasing pet ownership and heightened awareness of animal health. However, many small-to-medium veterinary clinics still rely on:

- **Paper-based medical records** — prone to loss, damage, and illegibility.
- **Phone/walk-in appointment booking** — inefficient, error-prone, and unavailable outside business hours.
- **Manual vaccination tracking** — leading to missed schedules and poor follow-up.
- **Disconnected billing and inventory** — causing revenue leakage and stock mismanagement.
- **No centralized data** — making reporting and management decisions difficult.

These inefficiencies result in poor patient experience, staff overload, and suboptimal clinical outcomes.

### 2.2 Objectives

| # | Objective |
|---|-----------|
| O-01 | Digitize and centralize all patient (pet) medical records and history |
| O-02 | Enable 24/7 online appointment booking and scheduling management |
| O-03 | Automate vaccination reminders and tracking schedules |
| O-04 | Streamline clinical workflow from check-in → examination → prescription → billing |
| O-05 | Provide role-based access for Pet Owners, Receptionists, Veterinarians, and Managers |
| O-06 | Generate management reports (revenue, patient statistics, inventory) |
| O-07 | Deliver a working Java-based prototype demonstrating core functionalities |

---

## 3. System Scope

### ✅ In Scope (What the system DOES)

| Domain | Capabilities |
|--------|-------------|
| **Appointment Management** | Online booking, rescheduling, cancellation, calendar view, waitlist |
| **Patient (Pet) Records** | Create/update pet profiles, medical history, allergy records |
| **Medical Examination** | SOAP-format examination notes, diagnosis recording, lab orders |
| **Electronic Health Records (EHR)** | Full visit history, diagnosis codes, treatment plans |
| **Vaccination Management** | Vaccine schedules, administration records, auto-reminders |
| **Prescription Management** | Digital prescriptions, medication instructions, refill tracking |
| **Billing & Invoicing** | Service-based billing, invoice generation, payment tracking |
| **Inventory Management** | Medicine/supply stock tracking, low-stock alerts |
| **User & Role Management** | CRUD users, assign roles (Admin, Vet, Receptionist, Pet Owner) |
| **Notifications** | Email/SMS reminders for appointments and vaccinations |
| **Reporting & Dashboard** | Revenue reports, patient statistics, staff performance |

### ❌ Out of Scope (What the system does NOT do)

- Telemedicine or video consultation features
- Integration with external laboratory systems (Phase 2)
- Multi-branch/multi-clinic management
- Mobile native applications (iOS/Android)
- Insurance claim processing
- Pet boarding or grooming management

---

## 4. Key Features

```
┌─────────────────────────────────────────────────────────────────┐
│                        VETCARE PRO                              │
├──────────────────┬──────────────────┬───────────────────────────┤
│  🗓️ SCHEDULING   │  🐾 MEDICAL      │  💊 PHARMACY              │
│  · Online booking│  · EHR / SOAP    │  · Prescription Mgmt      │
│  · Auto-reminders│  · Diagnosis     │  · Drug inventory          │
│  · Queue mgmt    │  · Lab orders    │  · Dispensing records      │
├──────────────────┼──────────────────┼───────────────────────────┤
│  💉 VACCINATION  │  💵 BILLING      │  📊 MANAGEMENT            │
│  · Vaccine sched │  · Auto-invoice  │  · Dashboard analytics    │
│  · Cert issuance │  · Payment track │  · Staff management       │
│  · Batch reminders│ · Revenue report│  · Audit logs             │
└──────────────────┴──────────────────┴───────────────────────────┘
```

---

## 5. Stakeholders

| Stakeholder | Role in System | Primary Concerns |
|-------------|----------------|-----------------|
| **Pet Owner / Customer** | Books appointments, views records, receives reminders | Ease of use, transparency, timely notifications |
| **Veterinarian (Doctor)** | Records examinations, issues prescriptions, manages cases | Efficient workflow, accurate records, patient history |
| **Receptionist / Nurse** | Manages appointments, check-in, basic patient data | Quick data entry, schedule visibility |
| **Clinic Manager / Admin** | Oversees operations, views reports, manages staff | Revenue tracking, staff performance, compliance |
| **System Administrator** | Manages users, roles, system configuration | Security, uptime, data integrity |
| **Pharmacy/Inventory Staff** | Manages medicine stock, fulfills prescriptions | Stock accuracy, low-stock alerts |

---

## 6. Technology Stack

### Backend (Java Demo)
| Layer | Technology |
|-------|-----------|
| Language | Java 17+ |
| Framework | Spring Boot 3.x |
| ORM | Spring Data JPA / Hibernate |
| Database | MySQL 8.x |
| Security | Spring Security + JWT |
| Build Tool | Maven |

### Frontend / Prototype
| Layer | Technology |
|-------|-----------|
| Prototype | Figma (high-fidelity wireframes) |
| Web UI (demo) | Thymeleaf / Bootstrap 5 |
| Java Demo Alt. | JavaFX or Swing (console fallback) |

### DevOps / Tools
| Category | Tools |
|----------|-------|
| Version Control | Git + GitHub |
| UML Modeling | PlantUML / draw.io / StarUML |
| Documentation | Microsoft Word + Markdown |
| IDE | IntelliJ IDEA / Eclipse |

---

## 7. Project Structure

```
RAD_Final/
│
├── README.md                         # This file — project overview
├── .agent/
│   └── workflow/
│       ├── 01_requirements.md        # Requirements identification & specification
│       ├── 02_use_cases.md           # Use case specifications (5–7 detailed UCs)
│       ├── 03_uml_diagrams.md        # UML diagram descriptions & PlantUML code
│       ├── 04_database_design.md     # Relational schema & data dictionary
│       ├── 05_ui_design.md           # UI wireframe descriptions & nav flow
│       └── 06_demo_script.md         # Java demo script & sample data
│
├── docs/
│   ├── report/                       # Final report (Word/PDF)
│   ├── uml/                          # Exported UML diagrams (PNG/SVG)
│   ├── wireframes/                   # Exported Figma screens
│   └── database/                     # SQL schema files
│
├── src/                              # Java source code (Spring Boot project)
│   ├── main/
│   │   ├── java/com/vetcare/
│   │   │   ├── controller/
│   │   │   ├── service/
│   │   │   ├── repository/
│   │   │   ├── model/
│   │   │   ├── dto/
│   │   │   └── VetCareApplication.java
│   │   └── resources/
│   │       ├── application.properties
│   │       └── templates/            # Thymeleaf HTML templates
│   └── test/
│
├── figma/
│   └── figma-export-links.md         # Figma prototype links & notes
│
└── demo/
    ├── sample-data.sql               # Sample data for demo
    └── demo-script.md                # Step-by-step live demo guide
```

---

## 8. UML Artifacts

| Diagram | Description | File |
|---------|-------------|------|
| Overall Use Case Diagram | All actors and major use cases | `docs/uml/usecase-overall.png` |
| Detailed Use Cases (×7) | UC-01 through UC-07 full spec | `.agent/workflow/02_use_cases.md` |
| Class Diagram | Core domain entities & relationships | `docs/uml/class-diagram.png` |
| ERD | Database entity relationships | `docs/uml/erd.png` |
| Sequence Diagram — Book Appointment | Full booking flow | `docs/uml/seq-book-appointment.png` |
| Sequence Diagram — Examination | Vet examination workflow | `docs/uml/seq-examination.png` |
| Sequence Diagram — Vaccination | Vaccination recording flow | `docs/uml/seq-vaccination.png` |
| Activity Diagram — Check-in Process | Patient check-in activities | `docs/uml/activity-checkin.png` |

---

## 9. Database Design

### Core Entities (Relational Schema Overview)

| Table | Description |
|-------|-------------|
| `users` | System accounts for all roles |
| `pet_owners` | Customer profiles linked to users |
| `pets` | Pet (patient) profiles |
| `veterinarians` | Vet profiles, specialization, schedule |
| `appointments` | Booking records with status tracking |
| `medical_records` | SOAP notes per visit |
| `diagnoses` | Diagnosis entries linked to medical records |
| `prescriptions` | Prescription headers |
| `prescription_items` | Line items (drug, dose, frequency) |
| `vaccinations` | Vaccination events and schedules |
| `vaccines` | Vaccine catalog |
| `invoices` | Billing documents |
| `invoice_items` | Line items (services, medicines) |
| `medicines` | Medicine/drug catalog |
| `inventory` | Stock levels per medicine |
| `services` | Clinic service catalog (exam, lab, etc.) |
| `notifications` | Reminder and alert queue |
| `roles` | Role definitions |
| `user_roles` | Many-to-many user↔role mapping |

> Full schema with primary keys, foreign keys, data types, and constraints is in `.agent/workflow/04_database_design.md`

---

## 10. Prototype & Demo

### 10.1 Figma Prototype
- High-fidelity, clickable UI prototype
- Covers: Login → Dashboard → Appointment Booking → Pet Profile → Medical Records → Vaccination → Billing
- Navigation follows role-based views (Pet Owner vs. Vet vs. Receptionist vs. Admin)

### 10.2 Java Demo Functions (Live Demonstration)

| # | Function | Implementation |
|---|----------|----------------|
| D-01 | **User Login & RBAC** | Spring Security + JWT, role-based menu |
| D-02 | **Pet Profile Management** | CRUD pet profiles, link to owner |
| D-03 | **Appointment Booking** | Create/view/cancel appointments, slot availability |
| D-04 | **Medical Record & Vaccination** | SOAP notes, diagnosis, vaccination recording |
| D-05 | **Invoice Generation** | Auto-generate from visit, payment tracking |

### 10.3 Demo Script
- See `demo/demo-script.md` for step-by-step live demo flow
- Sample data: `demo/sample-data.sql` (5 pets, 3 owners, 2 vets, 10 appointments)

---

## 11. Team Members

| # | Full Name | Student ID | Main Responsibilities | Contribution |
|---|-----------|------------|----------------------|-------------|
| 1 | [Name 1] | [ID] | Project Lead, Use Cases, Architecture | 25% |
| 2 | [Name 2] | [ID] | Requirements, Database Design, Report | 25% |
| 3 | [Name 3] | [ID] | Java Backend (Spring Boot), Demo | 25% |
| 4 | [Name 4] | [ID] | Figma Prototype, UI Design, UML Diagrams | 25% |

> Full task breakdown with signatures is in the Report Appendix.

---

## 12. References

1. Sommerville, I. (2016). *Software Engineering* (10th ed.). Pearson.
2. Larman, C. (2004). *Applying UML and Patterns* (3rd ed.). Prentice Hall.
3. Fowler, M. (2003). *UML Distilled* (3rd ed.). Addison-Wesley.
4. Spring Boot Documentation: https://spring.io/projects/spring-boot
5. MySQL 8.0 Reference Manual: https://dev.mysql.com/doc/refman/8.0/
6. Object Management Group — UML 2.5 Specification: https://www.omg.org/spec/UML/

---

<div align="center">

**VetCare Pro** · RAD Final Project · Software Engineering Dept.  
*"Caring for pets, powered by technology"* 🐾

</div>
