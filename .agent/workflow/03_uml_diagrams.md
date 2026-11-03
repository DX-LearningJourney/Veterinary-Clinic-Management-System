# Workflow Document 03 — UML Diagrams (Mermaid Code)
## VetCare Pro: Veterinary Clinic Management System

> **Status:** ✅ FINALIZED  
> **Last Updated:** 2026-11-04  
> **Tool:** Mermaid (render in VS Code with Markdown Preview Mermaid Support, or paste into https://mermaid.live)

---

## Diagram Index

| # | Diagram | Type | Use Cases |
|---|---------|------|-----------|
| D-01 | [Overall Use Case Overview](#d-01-overall-use-case-overview) | Flowchart (Use Case style) | All UCs |
| D-02 | [Class Diagram](#d-02-class-diagram) | `classDiagram` | All |
| D-03 | [Entity-Relationship Diagram (ERD)](#d-03-entity-relationship-diagram-erd) | `erDiagram` | All |
| D-04 | [Sequence Diagram — Book Appointment](#d-04-sequence-diagram--book-appointment-uc-03) | `sequenceDiagram` | UC-03 |
| D-05 | [Sequence Diagram — Medical Examination](#d-05-sequence-diagram--medical-examination--record-uc-04) | `sequenceDiagram` | UC-04 |
| D-06 | [Sequence Diagram — Process Payment](#d-06-sequence-diagram--process-payment--invoice-uc-07) | `sequenceDiagram` | UC-07 |
| D-07 | [Activity Diagram — Patient Check-in Flow](#d-07-activity-diagram--patient-check-in-flow) | `flowchart TD` | UC-03, UC-04 |
| D-08 | [State Diagram — Appointment Lifecycle](#d-08-state-diagram--appointment-lifecycle) | `stateDiagram-v2` | UC-03, UC-07 |

---

## D-01: Overall Use Case Overview

> Rendered as a structured flowchart since Mermaid does not have native use case diagram syntax.
> Oval shapes = Use Cases | Rectangle = Actors | Arrows = "can perform"

```mermaid
flowchart LR
    %% Actors
    PO(["👤 Pet Owner"])
    VET(["🩺 Veterinarian"])
    RECEP(["📋 Receptionist"])
    MGR(["📊 Clinic Manager"])
    SYS(["⚙️ System\n(Automated)"])

    %% Use Cases
    UC01["UC-01\nLogin & Auth"]
    UC02["UC-02\nManage Pet Profile"]
    UC03["UC-03\nBook Appointment"]
    UC04["UC-04\nMedical Examination\n& Record"]
    UC05["UC-05\nRecord Vaccination"]
    UC06["UC-06\nIssue Prescription"]
    UC07["UC-07\nProcess Payment\n& Invoice"]
    UC08["UC-08\nManage Users\n& Roles"]
    UC09["UC-09\nView Reports\n& Dashboard"]
    UC10["UC-10\nSend Notifications\n& Reminders"]

    %% Pet Owner links
    PO --> UC01
    PO --> UC02
    PO --> UC03

    %% Veterinarian links
    VET --> UC01
    VET --> UC04
    VET --> UC05
    VET --> UC06

    %% Receptionist links
    RECEP --> UC01
    RECEP --> UC02
    RECEP --> UC03
    RECEP --> UC07

    %% Manager links
    MGR --> UC01
    MGR --> UC08
    MGR --> UC09

    %% System links
    SYS --> UC10

    %% Relationships between UCs
    UC03 -->|"includes"| UC01
    UC04 -->|"includes"| UC01
    UC04 -->|"extends"| UC05
    UC04 -->|"extends"| UC06
    UC06 -->|"extends"| UC07
    UC07 -->|"includes"| UC04

    %% Styling
    classDef actor fill:#dbeafe,stroke:#2563eb,color:#1e3a8a,rx:50
    classDef usecase fill:#fef9c3,stroke:#d97706,color:#78350f
    classDef system fill:#dcfce7,stroke:#16a34a,color:#14532d
    class PO,VET,RECEP,MGR actor
    class SYS system
    class UC01,UC02,UC03,UC04,UC05,UC06,UC07,UC08,UC09,UC10 usecase
```

---

## D-02: Class Diagram

> Covers all core domain entities of the VetCare Pro system with attributes, methods, and relationships.

```mermaid
classDiagram
    direction TB

    class User {
        +Long id
        +String username
        +String email
        +String passwordHash
        +Boolean isActive
        +LocalDateTime createdAt
        +login() Boolean
        +logout() void
        +changePassword(newPwd) void
    }

    class PetOwner {
        +Long id
        +String fullName
        +String phone
        +String address
        +registerPet(pet) Pet
        +getMyPets() List~Pet~
    }

    class Veterinarian {
        +Long id
        +String fullName
        +String specialization
        +String licenseNumber
        +createMedicalRecord(record) MedicalRecord
        +issuePrescription(rx) Prescription
        +recordVaccination(vacc) Vaccination
        +getSchedule(date) List~Appointment~
    }

    class Receptionist {
        +Long id
        +String fullName
        +String employeeCode
        +createAppointment(apt) Appointment
        +checkInPatient(aptId) void
        +processPayment(invId) Invoice
    }

    class Pet {
        +Long id
        +String name
        +String species
        +String breed
        +LocalDate dateOfBirth
        +String gender
        +Double weight
        +String microchipId
        +String knownAllergies
        +String photo
        +getAge() Integer
        +getMedicalHistory() List~MedicalRecord~
        +getVaccinationStatus() List~Vaccination~
    }

    class Appointment {
        +Long id
        +LocalDateTime scheduledAt
        +AppointmentStatus status
        +String reasonForVisit
        +String notes
        +LocalDateTime createdAt
        +confirm() void
        +cancel(reason) void
        +checkIn() void
        +complete() void
    }

    class MedicalRecord {
        +Long id
        +LocalDateTime visitDate
        +String subjective
        +String objective
        +String assessment
        +String plan
        +Double weightKg
        +Double temperatureCelsius
        +Integer heartRateBpm
        +Integer respiratoryRate
        +String additionalNotes
        +getSummary() String
    }

    class Diagnosis {
        +Long id
        +String diagnosisName
        +String icdCode
        +String severity
        +String notes
        +Boolean isPrimary
    }

    class Prescription {
        +Long id
        +LocalDate issuedDate
        +LocalDate expiryDate
        +PrescriptionStatus status
        +String notes
        +getTotalCost() Double
    }

    class PrescriptionItem {
        +Long id
        +String dosage
        +String frequency
        +Integer durationDays
        +String instructions
        +Integer quantity
    }

    class Vaccination {
        +Long id
        +LocalDate administeredDate
        +LocalDate nextDueDate
        +String batchNumber
        +String notes
        +Boolean reminderSent
        +isOverdue() Boolean
        +getDaysUntilDue() Long
    }

    class Vaccine {
        +Long id
        +String name
        +String manufacturer
        +String description
        +Integer intervalDays
        +String targetSpecies
    }

    class Invoice {
        +Long id
        +LocalDateTime issuedAt
        +Double subtotal
        +Double tax
        +Double totalAmount
        +Double amountPaid
        +PaymentStatus paymentStatus
        +String paymentMethod
        +LocalDateTime paidAt
        +getBalance() Double
        +generatePDF() byte[]
    }

    class InvoiceItem {
        +Long id
        +String description
        +ItemType itemType
        +Integer quantity
        +Double unitPrice
        +Double subtotal
        +calculateSubtotal() Double
    }

    class Medicine {
        +Long id
        +String name
        +String activeIngredient
        +String dosageForm
        +String unit
        +Double unitPrice
        +Integer stockQuantity
        +Integer minStockThreshold
        +isLowStock() Boolean
        +adjustStock(qty) void
    }

    class Service {
        +Long id
        +String name
        +String category
        +String description
        +Double price
        +Boolean isActive
    }

    class Notification {
        +Long id
        +String type
        +String title
        +String message
        +LocalDateTime scheduledAt
        +Boolean isSent
        +String channel
        +send() void
    }

    %% Inheritance / Association: User ↔ Role Profiles
    User "1" --> "0..1" PetOwner : has profile
    User "1" --> "0..1" Veterinarian : has profile
    User "1" --> "0..1" Receptionist : has profile

    %% Ownership
    PetOwner "1" --> "1..*" Pet : owns
    PetOwner "1" --> "*" Appointment : books

    %% Appointment links
    Veterinarian "1" --> "*" Appointment : assigned to
    Pet "1" --> "*" Appointment : subject of
    Appointment "1" --> "0..1" MedicalRecord : generates
    Appointment "1" --> "0..1" Invoice : produces

    %% Medical Record links
    MedicalRecord "1" --> "1..*" Diagnosis : contains
    MedicalRecord "1" --> "0..1" Prescription : has

    %% Prescription links
    Prescription "1" --> "1..*" PrescriptionItem : includes
    PrescriptionItem "*" --> "1" Medicine : references

    %% Vaccination links
    Pet "1" --> "*" Vaccination : receives
    Vaccine "1" --> "*" Vaccination : used in
    Veterinarian "1" --> "*" Vaccination : administers

    %% Invoice links
    Invoice "1" --> "1..*" InvoiceItem : contains

    %% Notification
    User "1" --> "*" Notification : receives
```

---

## D-03: Entity-Relationship Diagram (ERD)

> Represents the relational database schema. Notation: `||--||` = one-to-one, `||--|{` = one-to-many, `}|--|{` = many-to-many.

```mermaid
erDiagram
    USERS {
        bigint id PK
        varchar username UK
        varchar email UK
        varchar password_hash
        boolean is_active
        datetime created_at
        datetime updated_at
    }

    ROLES {
        int id PK
        varchar name UK
        varchar description
    }

    USER_ROLES {
        bigint user_id FK
        int role_id FK
    }

    PET_OWNERS {
        bigint id PK
        bigint user_id FK
        varchar full_name
        varchar phone
        text address
        datetime created_at
    }

    VETERINARIANS {
        bigint id PK
        bigint user_id FK
        varchar full_name
        varchar specialization
        varchar license_number UK
        boolean is_available
    }

    RECEPTIONISTS {
        bigint id PK
        bigint user_id FK
        varchar full_name
        varchar employee_code UK
    }

    PETS {
        bigint id PK
        bigint owner_id FK
        varchar name
        varchar species
        varchar breed
        date date_of_birth
        varchar gender
        decimal weight
        varchar microchip_id UK
        text known_allergies
        varchar photo_url
        datetime created_at
    }

    APPOINTMENTS {
        bigint id PK
        bigint pet_id FK
        bigint vet_id FK
        bigint owner_id FK
        datetime scheduled_at
        varchar status
        text reason_for_visit
        text notes
        datetime created_at
        datetime updated_at
    }

    MEDICAL_RECORDS {
        bigint id PK
        bigint appointment_id FK "UNIQUE"
        datetime visit_date
        text subjective
        text objective
        text assessment
        text plan
        decimal weight_kg
        decimal temperature_celsius
        int heart_rate_bpm
        int respiratory_rate
        text additional_notes
        datetime created_at
    }

    DIAGNOSES {
        bigint id PK
        bigint medical_record_id FK
        varchar diagnosis_name
        varchar icd_code
        varchar severity
        text notes
        boolean is_primary
    }

    PRESCRIPTIONS {
        bigint id PK
        bigint medical_record_id FK "UNIQUE"
        date issued_date
        date expiry_date
        varchar status
        text notes
    }

    PRESCRIPTION_ITEMS {
        bigint id PK
        bigint prescription_id FK
        bigint medicine_id FK
        varchar dosage
        varchar frequency
        int duration_days
        text instructions
        int quantity
    }

    VACCINATIONS {
        bigint id PK
        bigint pet_id FK
        bigint vaccine_id FK
        bigint vet_id FK
        date administered_date
        date next_due_date
        varchar batch_number
        text notes
        boolean reminder_sent
    }

    VACCINES {
        bigint id PK
        varchar name UK
        varchar manufacturer
        text description
        int interval_days
        varchar target_species
    }

    MEDICINES {
        bigint id PK
        varchar name UK
        varchar active_ingredient
        varchar dosage_form
        varchar unit
        decimal unit_price
        int stock_quantity
        int min_stock_threshold
        boolean is_active
    }

    SERVICES {
        bigint id PK
        varchar name
        varchar category
        text description
        decimal price
        boolean is_active
    }

    INVOICES {
        bigint id PK
        bigint appointment_id FK "UNIQUE"
        datetime issued_at
        decimal subtotal
        decimal tax
        decimal total_amount
        decimal amount_paid
        varchar payment_status
        varchar payment_method
        datetime paid_at
    }

    INVOICE_ITEMS {
        bigint id PK
        bigint invoice_id FK
        varchar description
        varchar item_type
        int quantity
        decimal unit_price
        decimal subtotal
    }

    NOTIFICATIONS {
        bigint id PK
        bigint user_id FK
        varchar type
        varchar title
        text message
        datetime scheduled_at
        boolean is_sent
        varchar channel
        datetime sent_at
    }

    %% Relationships
    USERS ||--o| PET_OWNERS : "profiled as"
    USERS ||--o| VETERINARIANS : "profiled as"
    USERS ||--o| RECEPTIONISTS : "profiled as"
    USERS }o--o{ ROLES : "USER_ROLES"
    PET_OWNERS ||--|{ PETS : "owns"
    PET_OWNERS ||--|{ APPOINTMENTS : "books"
    VETERINARIANS ||--|{ APPOINTMENTS : "handles"
    PETS ||--|{ APPOINTMENTS : "subject of"
    APPOINTMENTS ||--o| MEDICAL_RECORDS : "generates"
    MEDICAL_RECORDS ||--|{ DIAGNOSES : "contains"
    MEDICAL_RECORDS ||--o| PRESCRIPTIONS : "has"
    PRESCRIPTIONS ||--|{ PRESCRIPTION_ITEMS : "includes"
    PRESCRIPTION_ITEMS }|--|| MEDICINES : "references"
    PETS ||--|{ VACCINATIONS : "receives"
    VACCINES ||--|{ VACCINATIONS : "used in"
    VETERINARIANS ||--|{ VACCINATIONS : "administers"
    APPOINTMENTS ||--o| INVOICES : "produces"
    INVOICES ||--|{ INVOICE_ITEMS : "contains"
    USERS ||--|{ NOTIFICATIONS : "receives"
```

---

## D-04: Sequence Diagram — Book Appointment (UC-03)

> **Actor:** Pet Owner | **Goal:** Successfully book a veterinary appointment online  
> Covers: happy path, slot conflict exception, confirmation notification

```mermaid
sequenceDiagram
    actor PO as Pet Owner
    participant UI as Browser / UI
    participant AppCtrl as AppointmentController
    participant AppSvc as AppointmentService
    participant VetRepo as VetRepository
    participant SlotSvc as SlotAvailabilityService
    participant AppRepo as AppointmentRepository
    participant NotiSvc as NotificationService

    PO->>UI: Navigate to Book Appointment page
    UI->>AppCtrl: GET /appointments/book
    AppCtrl->>AppSvc: getBookingFormData()
    AppSvc->>VetRepo: findAllActiveVets()
    VetRepo-->>AppSvc: List[Veterinarian]
    AppSvc-->>AppCtrl: BookingFormDTO
    AppCtrl-->>UI: Render booking form

    PO->>UI: Select pet, date, veterinarian
    UI->>AppCtrl: GET /appointments/slots?vetId=X&date=Y
    AppCtrl->>SlotSvc: getAvailableSlots(vetId, date)
    SlotSvc->>AppRepo: findByVetIdAndDate(vetId, date)
    AppRepo-->>SlotSvc: List[bookedSlots]
    SlotSvc-->>AppCtrl: List[availableTimeSlots]
    AppCtrl-->>UI: Return available slots list
    UI-->>PO: Display available time slots

    PO->>UI: Select time slot, enter reason for visit
    PO->>UI: Click "Confirm Booking"
    UI->>AppCtrl: POST /appointments (AppointmentRequest)
    AppCtrl->>AppSvc: bookAppointment(request, ownerId)

    AppSvc->>SlotSvc: isSlotStillAvailable(vetId, scheduledAt)
    SlotSvc->>AppRepo: existsByVetIdAndScheduledAtAndStatusNot(vetId, time, CANCELLED)

    alt Slot is Available
        AppRepo-->>SlotSvc: false
        SlotSvc-->>AppSvc: true
        AppSvc->>AppRepo: save(newAppointment)
        AppRepo-->>AppSvc: savedAppointment [status=PENDING]
        AppSvc->>NotiSvc: sendBookingConfirmation(owner, appointment)
        NotiSvc-->>AppSvc: notification queued
        AppSvc-->>AppCtrl: AppointmentDTO
        AppCtrl-->>UI: 201 Created + AppointmentDTO
        UI-->>PO: Show confirmation page with reference number
    else Slot Already Taken
        AppRepo-->>SlotSvc: true
        SlotSvc-->>AppSvc: false
        AppSvc-->>AppCtrl: throw SlotNotAvailableException
        AppCtrl-->>UI: 409 Conflict + error message
        UI-->>PO: "This slot is no longer available. Please select another time."
    end

    Note over NotiSvc: Async: Send confirmation email<br/>Schedule 24h reminder notification
```

---

## D-05: Sequence Diagram — Medical Examination & Record (UC-04)

> **Actor:** Veterinarian | **Goal:** Record a complete medical examination in SOAP format  
> Covers: check-in, SOAP notes, diagnosis, optional prescription trigger, record finalization

```mermaid
sequenceDiagram
    actor RECEP as Receptionist
    actor VET as Veterinarian
    participant UI as Browser / UI
    participant MRCtrl as MedicalRecordController
    participant MRSvc as MedicalRecordService
    participant AppRepo as AppointmentRepository
    participant PetRepo as PetRepository
    participant MRRepo as MedicalRecordRepository
    participant PrescCtrl as PrescriptionController
    participant PrescSvc as PrescriptionService

    RECEP->>UI: Mark patient as checked in
    UI->>AppRepo: updateStatus(appointmentId, CHECKED_IN)
    AppRepo-->>UI: Updated

    VET->>UI: Open Today's Appointments list
    UI->>MRCtrl: GET /appointments/today
    MRCtrl->>AppRepo: findByVetAndDateAndStatus(vetId, today, CHECKED_IN)
    AppRepo-->>MRCtrl: List[Appointment]
    MRCtrl-->>UI: Appointments list
    UI-->>VET: Show checked-in patients

    VET->>UI: Click patient to open examination
    UI->>MRCtrl: GET /medical-records/new?appointmentId=X
    MRCtrl->>AppRepo: findByIdWithDetails(appointmentId)
    AppRepo-->>MRCtrl: Appointment (with pet, owner)
    MRCtrl->>PetRepo: findWithFullHistory(petId)
    PetRepo-->>MRCtrl: Pet (with allergies, past records)
    MRCtrl-->>UI: Examination form + patient history
    UI-->>VET: Show SOAP form + patient info + allergy alerts

    Note over VET,UI: Veterinarian fills SOAP examination form

    VET->>UI: Enter Vital Signs (weight, temp, HR, RR)
    VET->>UI: Fill Subjective, Objective, Assessment, Plan
    VET->>UI: Add diagnosis entries (name, code, severity)
    VET->>UI: Click "Save Medical Record"

    UI->>MRCtrl: POST /medical-records (MedicalRecordRequest)
    MRCtrl->>MRSvc: createMedicalRecord(request)
    MRSvc->>MRRepo: save(medicalRecord)
    MRRepo-->>MRSvc: savedMedicalRecord [id=MR-001]
    MRSvc->>AppRepo: updateStatus(appointmentId, COMPLETED)
    AppRepo-->>MRSvc: updated
    MRSvc-->>MRCtrl: MedicalRecordDTO
    MRCtrl-->>UI: 201 Created + next action options
    UI-->>VET: Record saved. Options: [Issue Prescription] [Record Vaccination] [Done]

    opt Veterinarian Issues Prescription
        VET->>UI: Click "Issue Prescription"
        UI->>PrescCtrl: GET /prescriptions/new?medicalRecordId=MR-001
        PrescCtrl-->>UI: Prescription form with medicine search

        VET->>UI: Search & select medicines, enter dosage/frequency/duration
        VET->>UI: Click "Issue Prescription"
        UI->>PrescCtrl: POST /prescriptions (PrescriptionRequest)
        PrescCtrl->>PrescSvc: createPrescription(mrId, items)
        PrescSvc->>MRRepo: linkPrescription(mrId, prescription)
        MRRepo-->>PrescSvc: linked
        PrescSvc-->>PrescCtrl: PrescriptionDTO
        PrescCtrl-->>UI: Prescription saved [status=PENDING_DISPENSING]
        UI-->>VET: Prescription issued successfully
    end

    VET->>UI: Click "Done"
    UI-->>VET: Return to appointments list
```

---

## D-06: Sequence Diagram — Process Payment & Invoice (UC-07)

> **Actor:** Receptionist | **Goal:** Generate and finalize invoice, collect payment  
> Covers: auto invoice generation, line-item adjustment, payment processing, receipt

```mermaid
sequenceDiagram
    actor RECEP as Receptionist
    participant UI as Browser / UI
    participant InvCtrl as InvoiceController
    participant InvSvc as InvoiceService
    participant AppRepo as AppointmentRepository
    participant MRRepo as MedicalRecordRepository
    participant SvcCatalog as ServiceCatalogRepository
    participant InvRepo as InvoiceRepository
    participant PaySvc as PaymentService

    RECEP->>UI: Navigate to Billing → Pending Invoices
    UI->>InvCtrl: GET /invoices/pending
    InvCtrl->>AppRepo: findCompletedWithoutInvoice()
    AppRepo-->>InvCtrl: List[Appointment]
    InvCtrl-->>UI: Pending billing list
    UI-->>RECEP: Display appointments ready for billing

    RECEP->>UI: Select appointment to generate invoice
    UI->>InvCtrl: POST /invoices/generate (appointmentId)
    InvCtrl->>InvSvc: generateInvoice(appointmentId)

    InvSvc->>AppRepo: findByIdWithDetails(appointmentId)
    AppRepo-->>InvSvc: Appointment (with MedicalRecord, Prescription)
    InvSvc->>MRRepo: findWithPrescription(medicalRecordId)
    MRRepo-->>InvSvc: MedicalRecord + PrescriptionItems
    InvSvc->>SvcCatalog: findServicePrice(CONSULTATION)
    SvcCatalog-->>InvSvc: service price
    InvSvc->>InvSvc: buildInvoiceItems(services + medicines)
    InvSvc->>InvSvc: calculateTotal(items)
    InvSvc->>InvRepo: save(invoice)
    InvRepo-->>InvSvc: savedInvoice [status=UNPAID]
    InvSvc-->>InvCtrl: InvoiceDTO
    InvCtrl-->>UI: Invoice generated
    UI-->>RECEP: Display invoice with line items and total

    opt Receptionist Modifies Line Items
        RECEP->>UI: Add/Remove invoice line items
        UI->>InvCtrl: PUT /invoices/INV-ID/items (UpdateItemsRequest)
        InvCtrl->>InvSvc: updateInvoiceItems(invoiceId, updatedItems)
        InvSvc->>InvRepo: updateItems(invoiceId, updatedItems)
        InvSvc->>InvRepo: recalculateTotal(invoiceId)
        InvRepo-->>InvSvc: updated
        InvSvc-->>InvCtrl: Updated InvoiceDTO
        InvCtrl-->>UI: Invoice updated
        UI-->>RECEP: Show updated total
    end

    RECEP->>UI: Select payment method (Cash / Bank Transfer / Card)
    RECEP->>UI: Enter amount received
    RECEP->>UI: Click "Confirm Payment"
    UI->>InvCtrl: POST /invoices/INV-ID/pay (PaymentRequest)
    InvCtrl->>PaySvc: processPayment(invoiceId, method, amount)

    PaySvc->>InvRepo: findById(invoiceId)
    InvRepo-->>PaySvc: Invoice [totalAmount]
    PaySvc->>PaySvc: validatePayment(amount, totalAmount)

    alt Full Payment (amount >= total)
        PaySvc->>InvRepo: updatePayment(invoiceId, PAID, amount, method, now)
        InvRepo-->>PaySvc: updated
        PaySvc->>AppRepo: updateStatus(appointmentId, CLOSED)
        AppRepo-->>PaySvc: updated
        PaySvc-->>InvCtrl: PaymentConfirmation [status=PAID]
        InvCtrl-->>UI: 200 OK + receipt data
        UI-->>RECEP: Payment successful — Show receipt + Print option
    else Partial Payment (amount < total)
        PaySvc->>InvRepo: updatePayment(invoiceId, PARTIALLY_PAID, amount, method, now)
        InvRepo-->>PaySvc: updated
        PaySvc-->>InvCtrl: PaymentConfirmation [status=PARTIALLY_PAID, balance=X]
        InvCtrl-->>UI: 200 OK + partial receipt
        UI-->>RECEP: Partial payment recorded. Balance due: [amount]
    else Invalid Payment (amount <= 0)
        PaySvc-->>InvCtrl: throw InvalidPaymentException
        InvCtrl-->>UI: 400 Bad Request
        UI-->>RECEP: "Invalid amount. Please enter a valid payment amount."
    end

    Note over UI,RECEP: Receipt options: Print PDF / Email to Pet Owner
```

---

## D-07: Activity Diagram — Patient Check-in Flow

> Covers the end-to-end flow from patient arrival at clinic to start of examination.

```mermaid
flowchart TD
    A([🏁 Patient Arrives at Clinic]) --> B[Receptionist searches\nappointment by name/phone]
    B --> C{Appointment\nFound?}

    C -- No --> D[Receptionist checks\nfor walk-in slot]
    D --> E{Walk-in Slot\nAvailable?}
    E -- No --> F[Inform patient:\nnext available slot]
    F --> G([❌ End: No Appointment])
    E -- Yes --> H[Create walk-in appointment\nstatus = CONFIRMED]
    H --> I

    C -- Yes --> I[Display appointment details\nand pet info]
    I --> J{Appointment\nStatus?}

    J -- CANCELLED --> K[Inform patient:\nappointment was cancelled]
    K --> G

    J -- PENDING / CONFIRMED --> L[Verify pet owner identity\ncheck photo ID]
    L --> M{Identity\nVerified?}
    M -- No --> N[Escalate to manager]
    N --> G

    M -- Yes --> O[Confirm pet being\nbrought in matches record]
    O --> P{Pet matches\nrecord?}
    P -- No --> Q[Update pet details\nif needed]
    Q --> R
    P -- Yes --> R[Collect any pre-visit forms\nor allergy updates]
    R --> S[Mark appointment:\nstatus = CHECKED_IN]
    S --> T[Notify assigned Veterinarian\npatient is ready]
    T --> U[Patient waits\nin waiting area]
    U --> V{Vet calls\npatient?}
    V -- Waiting --> U
    V -- Called --> W[Patient enters\nexamination room]
    W --> X([✅ End: Examination Begins\nTrigger UC-04])

    style A fill:#86efac,stroke:#16a34a
    style G fill:#fca5a5,stroke:#dc2626
    style X fill:#86efac,stroke:#16a34a
    style S fill:#bfdbfe,stroke:#2563eb
```

---

## D-08: State Diagram — Appointment Lifecycle

> Shows all valid states an appointment can be in and the transitions between them.

```mermaid
stateDiagram-v2
    [*] --> PENDING : Pet Owner books online

    PENDING --> CONFIRMED : Receptionist confirms\nor auto-confirm (24h)
    PENDING --> CANCELLED : Pet Owner cancels\nbefore confirmation

    CONFIRMED --> CHECKED_IN : Receptionist marks\npatient arrived
    CONFIRMED --> CANCELLED : Pet Owner / Staff cancels\n(≥ 2h before appointment)
    CONFIRMED --> NO_SHOW : Patient did not arrive\n(marked end of day)

    CHECKED_IN --> IN_PROGRESS : Veterinarian starts\nexamination

    IN_PROGRESS --> COMPLETED : Medical record saved\n(examination finished)

    COMPLETED --> CLOSED : Invoice paid\n(payment confirmed)

    CANCELLED --> [*] : Terminal state
    NO_SHOW --> [*] : Terminal state
    CLOSED --> [*] : Terminal state

    note right of PENDING
        Auto-reminder sent
        24h before scheduled time
    end note

    note right of COMPLETED
        Invoice auto-generated
        Prescription available
        for pharmacy
    end note
```

---

## Rendering Instructions

### Option 1 — VS Code (Recommended)
1. Install extension: **Markdown Preview Mermaid Support** (`bierner.markdown-mermaid`)
2. Open any `.md` file → Press `Ctrl+Shift+V` to preview
3. All diagrams render inline

### Option 2 — Mermaid Live Editor
1. Go to https://mermaid.live
2. Copy any code block (without the triple backticks)
3. Paste into editor → diagram renders on right panel
4. Export as PNG/SVG for report

### Option 3 — GitHub
Push to GitHub repository — all Mermaid blocks auto-render in GitHub Markdown preview.

---

## Export Targets for Report

| Diagram | Export File | Insert in Report Section |
|---------|------------|--------------------------|
| D-01 Use Case Overview | `docs/uml/usecase-overview.png` | Section 4.1 — Use Case Diagram |
| D-02 Class Diagram | `docs/uml/class-diagram.png` | Section 4.2 — Class Diagram |
| D-03 ERD | `docs/uml/erd.png` | Section 4.2 — ERD / Section 5 — DB Design |
| D-04 Sequence — Booking | `docs/uml/seq-book-appointment.png` | Section 4.3 — Sequence Diagrams |
| D-05 Sequence — Examination | `docs/uml/seq-examination.png` | Section 4.3 — Sequence Diagrams |
| D-06 Sequence — Payment | `docs/uml/seq-payment.png` | Section 4.3 — Sequence Diagrams |
| D-07 Activity — Check-in | `docs/uml/activity-checkin.png` | Section 4.3 — Activity Diagrams |
| D-08 State — Appointment | `docs/uml/state-appointment.png` | Section 4.3 — State Diagrams |

---

*Next: → [`04_database_design.md`](./04_database_design.md) — Full Relational Schema & Data Dictionary*

