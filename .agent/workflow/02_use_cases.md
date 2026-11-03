# Workflow Document 02 — Use Case Specifications
## VetCare Pro: Veterinary Clinic Management System

> **Status:** ✅ FINALIZED  
> **Last Updated:** 2026-11-04  
> **Decisions Applied:** Spring Boot + MySQL + Mermaid  
> **Sequence Diagrams Assigned:** UC-03, UC-04, UC-07

---

## Actors Summary

| Actor ID | Actor Name | Description |
|----------|-----------|-------------|
| A-01 | **Pet Owner** | Registered customer who books appointments, views pet records |
| A-02 | **Veterinarian** | Licensed vet who performs examinations, records diagnoses, issues prescriptions |
| A-03 | **Receptionist** | Clinic staff who manages appointments, check-in, and billing |
| A-04 | **Clinic Manager** | Admin role with access to reports and user management |
| A-05 | **System** | Automated system actor (notifications, reminders, invoice generation) |

---

## Use Case Index

| UC ID | Use Case Name | Primary Actor | Sequence Diagram |
|-------|--------------|---------------|-----------------|
| UC-01 | User Login & Authentication | All Actors | — |
| UC-02 | Manage Pet Profile | Pet Owner, Receptionist | — |
| **UC-03** | **Book Appointment** | Pet Owner, Receptionist | ✅ SD-01 |
| **UC-04** | **Conduct Medical Examination & Record** | Veterinarian | ✅ SD-02 |
| UC-05 | Record Vaccination | Veterinarian | — |
| UC-06 | Issue Prescription | Veterinarian | — |
| **UC-07** | **Process Payment & Generate Invoice** | Receptionist | ✅ SD-03 |

---

## UC-01: User Login & Authentication

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-01 |
| **Use Case Name** | User Login & Authentication |
| **Actor(s)** | All system users (Pet Owner, Veterinarian, Receptionist, Manager) |
| **Related FRs** | FR-02, FR-03, FR-05 |
| **Priority** | Must Have |

### Description
This use case describes how a registered user authenticates into the VetCare Pro system and is directed to a role-appropriate dashboard.

### Preconditions
1. The user has a valid registered account in the system.
2. The user's account is in **Active** status.
3. The login page is accessible via web browser.

### Postconditions
**Success:** The user is authenticated and redirected to their role-based dashboard with appropriate menu access.  
**Failure:** The user remains on the login page with an error message.

### Main Flow of Events

| Step | Actor | Action |
|------|-------|--------|
| 1 | Pet Owner | Navigates to `https://vetcare.clinic/login` |
| 2 | System | Displays the login form (email, password fields) |
| 3 | Actor | Enters email address and password, clicks **Login** |
| 4 | System | Validates input format (non-empty, valid email format) |
| 5 | System | Queries user record by email; verifies bcrypt password hash |
| 6 | System | Retrieves user roles (RBAC lookup) |
| 7 | System | Issues JWT access token (60-min TTL) + refresh token |
| 8 | System | Redirects user to role-specific dashboard |

### Alternative Flows

**A1 — Remember Me:**
- At Step 3: Actor checks "Remember Me" → System sets refresh token TTL to 30 days → persistent session

**A2 — Forgot Password:**
- At Step 3: Actor clicks "Forgot Password" → redirected to UC-01-FP
- System sends OTP/reset link to registered email
- Actor sets new password → redirected to login

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Wrong password (attempts < 5) | Display "Invalid credentials" error; increment attempt counter |
| **E2** | Wrong password (attempt = 5) | Lock account for 15 minutes; send security alert email |
| **E3** | Account inactive/deactivated | Display "Account is inactive, contact admin" |
| **E4** | Empty fields submitted | Display inline field validation errors |
| **E5** | JWT expired mid-session | Auto-redirect to login with "Session expired" message |

---

## UC-02: Manage Pet Profile

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-02 |
| **Use Case Name** | Manage Pet Profile (Create / View / Update) |
| **Actor(s)** | Pet Owner (primary), Receptionist (secondary) |
| **Related FRs** | FR-06, FR-07, FR-08, FR-09 |
| **Priority** | Must Have |

### Description
Allows Pet Owners to register and manage their pets' profiles, including medical background, allergies, and basic information.

### Preconditions
1. Actor is authenticated (UC-01 completed).
2. Actor is a **Pet Owner** or **Receptionist**.

### Postconditions
**Success:** Pet profile is created or updated in the database; pet appears in the owner's pet list.

### Main Flow of Events — Create Pet Profile

| Step | Actor | Action |
|------|-------|--------|
| 1 | Pet Owner | Navigates to **My Pets → Add New Pet** |
| 2 | System | Displays pet registration form |
| 3 | Pet Owner | Fills: Name, Species, Breed, DOB, Gender, Weight, Microchip ID, Photo |
| 4 | Pet Owner | Optionally enters known allergies and pre-existing conditions |
| 5 | Pet Owner | Clicks **Save** |
| 6 | System | Validates required fields; checks microchip ID uniqueness |
| 7 | System | Saves pet record linked to the owner's account |
| 8 | System | Displays success message and new pet's profile page |

### Main Flow — View Medical History

| Step | Actor | Action |
|------|-------|--------|
| 1 | Actor | Navigates to pet profile → **Medical History** tab |
| 2 | System | Retrieves all medical records, vaccinations, and prescriptions |
| 3 | System | Displays chronological history (most recent first) |
| 4 | Actor | Clicks on a specific visit to expand detail |

### Alternative Flows

**A1 — Receptionist registers pet on behalf of owner:**
- Receptionist searches for/creates an owner record first, then follows same creation flow.

**A2 — Update existing pet profile:**
- Actor clicks **Edit** on existing pet → modifies fields → saves → System updates record.

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Duplicate microchip ID | Error: "Microchip ID already registered to another pet" |
| **E2** | Missing required fields | Inline validation errors highlighted in red |
| **E3** | Invalid date of birth (future date) | Error: "Date of birth cannot be in the future" |

---

## UC-03: Book Appointment ⭐ [Sequence Diagram SD-01]

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-03 |
| **Use Case Name** | Book Appointment |
| **Actor(s)** | Pet Owner (online), Receptionist (on-behalf) |
| **Related FRs** | FR-10, FR-11, FR-12, FR-13, FR-14, FR-15, FR-16, FR-17 |
| **Priority** | Must Have |

### Description
The primary use case for scheduling a veterinary appointment. Pet Owners can book online 24/7, while Receptionists can create bookings on behalf of customers. The system validates time slot availability in real-time and confirms the booking with an automated notification.

### Preconditions
1. Actor is authenticated.
2. At least one pet profile exists in the actor's account.
3. At least one veterinarian has defined working hours in the system.

### Postconditions
**Success:** 
- A new appointment record is created with status = **PENDING**.
- A confirmation notification is queued (email/in-system).
- The appointment appears on the clinic's calendar.

**Failure:** No appointment is created; actor is shown an error.

### Main Flow of Events

| Step | Actor | Action |
|------|-------|--------|
| 1 | Pet Owner | Navigates to **Book Appointment** from dashboard |
| 2 | System | Displays booking form: pet selector, date picker, vet selector |
| 3 | Pet Owner | Selects **Pet**, desired **Date** |
| 4 | System | Fetches available veterinarians for selected date |
| 5 | System | Displays available **time slots** for each vet (real-time check) |
| 6 | Pet Owner | Selects **Veterinarian** and **Time Slot** |
| 7 | Pet Owner | Enters **Reason for Visit** (required); optional notes |
| 8 | Pet Owner | Clicks **Confirm Booking** |
| 9 | System | Re-validates slot availability (prevents race condition) |
| 10 | System | Creates appointment record (status: PENDING) |
| 11 | System | Queues confirmation email to Pet Owner |
| 12 | System | Displays booking confirmation page with appointment reference number |

### Alternative Flows

**A1 — Receptionist books on behalf of customer:**
- Steps 1–2: Receptionist navigates to **Manage Appointments → New Appointment**
- Receptionist searches for the customer by name/phone
- Remaining steps identical; status starts as **CONFIRMED** (receptionist-created bookings skip pending approval)

**A2 — Reschedule existing appointment:**
- Pet Owner navigates to **My Appointments → Select appointment → Reschedule**
- System displays new date/time selector
- After new slot selected and confirmed, old appointment cancelled, new one created
- Notification sent for reschedule confirmation

**A3 — Cancel appointment:**
- Pet Owner navigates to **My Appointments → Select appointment → Cancel**
- System prompts for cancellation reason
- Appointment status updated to **CANCELLED**
- Notification sent to both Pet Owner and Veterinarian

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Selected slot taken (race condition) | "This slot was just taken, please select another time" |
| **E2** | No available slots on selected date | "No availability on this date, try another date" |
| **E3** | Booking attempted for past date | Form validation prevents past-date selection |
| **E4** | No pet profile exists | Redirect to "Add Pet Profile" before allowing booking |
| **E5** | Cancellation within 2h of appointment | Warning: "Late cancellation may incur a fee" → confirm dialog |

---

## UC-04: Conduct Medical Examination & Record ⭐ [Sequence Diagram SD-02]

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-04 |
| **Use Case Name** | Conduct Medical Examination & Create Medical Record |
| **Actor(s)** | Veterinarian (primary), Receptionist (check-in step) |
| **Related FRs** | FR-08, FR-09, FR-18, FR-19, FR-21, FR-22 |
| **Priority** | Must Have |

### Description
The core clinical workflow. After a patient checks in, the Veterinarian conducts an examination using a structured SOAP format, records vital signs, enters diagnoses, and saves a comprehensive electronic health record (EHR) linked to the appointment.

### Preconditions
1. Veterinarian is authenticated with **VETERINARIAN** role.
2. An appointment exists with status **CONFIRMED** or **CHECKED_IN**.
3. Pet profile exists with accessible medical history.

### Postconditions
**Success:**
- A new Medical Record is saved with full SOAP notes.
- At least one Diagnosis is recorded.
- Appointment status updated to **COMPLETED**.
- Medical record visible in pet's history.

### Main Flow of Events

| Step | Actor | Action |
|------|-------|--------|
| 1 | Receptionist | Marks patient as checked-in → appointment status → **CHECKED_IN** |
| 2 | Veterinarian | Opens **Today's Appointments** → selects checked-in patient |
| 3 | System | Displays patient details: pet profile, **allergy alerts** (if any), past medical history |
| 4 | Veterinarian | Reviews pet history, notes any flagged conditions |
| 5 | Veterinarian | Clicks **Start Examination** |
| 6 | System | Opens SOAP examination form with vital signs section |
| 7 | Veterinarian | Records **Vital Signs**: Weight, Temperature, Heart Rate, Respiratory Rate |
| 8 | Veterinarian | Fills **Subjective**: Chief complaint as reported by owner |
| 9 | Veterinarian | Fills **Objective**: Physical examination findings |
| 10 | Veterinarian | Fills **Assessment**: Diagnosis (primary and secondary) |
| 11 | Veterinarian | Fills **Plan**: Treatment plan, follow-up instructions |
| 12 | Veterinarian | Clicks **Save Medical Record** |
| 13 | System | Validates all required fields |
| 14 | System | Saves medical record; updates appointment → **COMPLETED** |
| 15 | System | Displays saved record with summary and prompts for next steps (Prescription / Vaccination / Billing) |

### Alternative Flows

**A1 — Issue Prescription from within examination:**
- After Step 12, Veterinarian clicks **Add Prescription**
- Prescription form opens (linked to this medical record)
- Vet selects medicines from catalog, enters dosage/frequency/duration
- Prescription saved and linked to medical record
- → Triggers UC-06

**A2 — Record Vaccination during examination:**
- After Step 12, Veterinarian clicks **Record Vaccination**
- → Triggers UC-05

**A3 — Order Lab Tests:**
- After Step 10, Veterinarian clicks **Order Lab Test**
- Selects test type; order saved as PENDING LAB
- Record can be saved in DRAFT status; finalized after lab results arrive

**A4 — View past medical record (read-only):**
- Pet Owner navigates to My Pets → Medical History
- System displays records in chronological order (read-only)

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Attempt to create record for non-checked-in appointment | Error: "Patient must be checked in first" |
| **E2** | Missing required SOAP fields | Inline validation highlights incomplete sections |
| **E3** | Allergy conflict with prescribed medicine | Warning banner: "⚠️ Patient has known allergy to [ingredient]" |
| **E4** | Duplicate examination record for same appointment | Error: "Examination record already exists for this appointment" |

---

## UC-05: Record Vaccination

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-05 |
| **Use Case Name** | Record Vaccination |
| **Actor(s)** | Veterinarian |
| **Related FRs** | FR-23, FR-24, FR-25, FR-26, FR-27 |
| **Priority** | Must Have |

### Description
Allows Veterinarians to record a vaccine administration for a pet, including the vaccine type, batch number, date, and next due date. The system automatically schedules a reminder for the follow-up dose.

### Preconditions
1. Veterinarian is authenticated.
2. Pet profile exists.
3. Vaccine catalog has the relevant vaccine entry.

### Postconditions
**Success:** Vaccination record saved; next due date recorded; reminder notification scheduled.

### Main Flow of Events

| Step | Actor | Action |
|------|-------|--------|
| 1 | Veterinarian | Opens pet profile or examination page → **Vaccination** tab |
| 2 | System | Displays vaccination history and **due/overdue** indicators |
| 3 | Veterinarian | Clicks **Record New Vaccination** |
| 4 | System | Displays vaccination form |
| 5 | Veterinarian | Selects **Vaccine** from catalog |
| 6 | System | Auto-fills recommended next due date based on vaccine interval |
| 7 | Veterinarian | Confirms/adjusts **Administration Date**, **Batch Number**, **Next Due Date**, optional notes |
| 8 | Veterinarian | Clicks **Save** |
| 9 | System | Saves vaccination record linked to pet and veterinarian |
| 10 | System | Schedules reminder notification (7 days before next due date) |
| 11 | System | Optionally generates vaccination certificate (PDF) |

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Vaccine not in catalog | Admin must add vaccine to catalog first |
| **E2** | Administration date in future | Warning: "Date is in the future, please confirm" |
| **E3** | Possible duplicate (same vaccine within short interval) | Warning: "Pet received this vaccine X days ago, confirm?" |

---

## UC-06: Issue Prescription

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-06 |
| **Use Case Name** | Issue Digital Prescription |
| **Actor(s)** | Veterinarian |
| **Related FRs** | FR-28, FR-29, FR-30, FR-31 |
| **Priority** | Must Have |

### Description
Veterinarians can issue a digital prescription linked to a medical record. Pharmacy staff can view and dispense based on the prescription, and inventory is updated accordingly.

### Preconditions
1. Veterinarian is authenticated.
2. A Medical Record (UC-04) exists for the current visit.
3. Medicine catalog is populated.

### Postconditions
**Success:** Prescription saved with all line items; linked to medical record; accessible by pharmacy staff.

### Main Flow of Events

| Step | Actor | Action |
|------|-------|--------|
| 1 | Veterinarian | From Medical Record → clicks **Issue Prescription** |
| 2 | System | Opens prescription form, pre-filled with medical record reference |
| 3 | Veterinarian | Searches and selects medicine from catalog |
| 4 | System | Displays medicine details (active ingredient, available stock) |
| 5 | Veterinarian | Enters: **Dosage**, **Frequency**, **Duration (days)**, **Instructions** |
| 6 | Veterinarian | Clicks **+ Add Medicine** to add more line items |
| 7 | Veterinarian | Reviews all items, sets **Prescription Notes** |
| 8 | Veterinarian | Clicks **Issue Prescription** |
| 9 | System | Saves prescription, marks as **PENDING_DISPENSING** |
| 10 | System | Notifies pharmacy staff of new prescription |

### Alternative Flows

**A1 — Pharmacy Staff dispenses prescription:**
- Pharmacy Staff views pending prescriptions
- Marks each item as dispensed
- System deducts stock quantity from inventory
- Prescription status → **DISPENSED**

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Medicine out of stock | Warning: "⚠️ [Medicine] is out of stock" — vet can still prescribe, pharmacy flag it |
| **E2** | Allergy conflict detected | Warning: "Known allergy to [ingredient] detected" |
| **E3** | Prescription already exists for this record | Error: "Prescription already issued — edit existing?" |

---

## UC-07: Process Payment & Generate Invoice ⭐ [Sequence Diagram SD-03]

| Field | Details |
|-------|---------|
| **Use Case ID** | UC-07 |
| **Use Case Name** | Process Payment & Generate Invoice |
| **Actor(s)** | Receptionist (primary), System (auto-generation) |
| **Related FRs** | FR-32, FR-33, FR-34, FR-35, FR-36 |
| **Priority** | Must Have |

### Description
After a clinical visit is completed, the system automatically generates an invoice based on services rendered and medicines dispensed. The Receptionist reviews, adjusts if needed, collects payment, and issues a receipt.

### Preconditions
1. Receptionist is authenticated.
2. The appointment status is **COMPLETED** (medical record saved).
3. A service catalog is populated with prices.
4. At least one invoice line item exists (exam fee minimum).

### Postconditions
**Success:**
- Invoice is generated and saved with status = **PAID**.
- Appointment status updated to **CLOSED**.
- Payment record stored with method and timestamp.
- Pet Owner can view receipt in their account.

**Partial Payment:** Invoice status = **PARTIALLY_PAID**; balance recorded.

### Main Flow of Events

| Step | Actor | Action |
|------|-------|--------|
| 1 | Receptionist | Navigates to **Billing → Pending Invoices** |
| 2 | System | Displays list of completed appointments without finalized payment |
| 3 | Receptionist | Selects appointment to bill |
| 4 | System | Auto-generates invoice with line items: exam fee, consultation, medicines dispensed, lab tests |
| 5 | System | Calculates subtotal, tax (if applicable), and **total amount** |
| 6 | Receptionist | Reviews line items |
| 7 | Receptionist | *Optional:* Adds/removes line items (e.g., add grooming, remove duplicate charge) |
| 8 | Receptionist | Selects **Payment Method**: Cash / Bank Transfer / Card |
| 9 | Receptionist | Enters **Amount Received** |
| 10 | System | Validates amount ≥ total due |
| 11 | System | Records payment; updates invoice status → **PAID** |
| 12 | System | Updates appointment status → **CLOSED** |
| 13 | System | Generates receipt (PDF) |
| 14 | Receptionist | Prints receipt or sends to Pet Owner's email |

### Alternative Flows

**A1 — Partial Payment:**
- Step 9: Amount received < total → System records partial payment
- Invoice status → **PARTIALLY_PAID**; balance carried forward
- Receptionist sets follow-up date for remaining balance

**A2 — Pet Owner views invoice online:**
- Pet Owner logs in → navigates to **Billing History**
- Views all invoices and receipts for their pets

**A3 — Manager views revenue report:**
- Manager navigates to **Reports → Revenue**
- System aggregates invoices by date range and category

### Exception Flows

| Exception | Trigger | System Response |
|-----------|---------|----------------|
| **E1** | Appointment not yet completed | Error: "Cannot invoice — examination not completed" |
| **E2** | Invoice already finalized | Error: "Invoice already paid — view receipt instead" |
| **E3** | Amount received less than 0 | Validation: "Amount must be positive" |
| **E4** | Payment method not selected | Validation: "Please select a payment method" |
| **E5** | System error during payment save | Rollback transaction; display "Payment failed, please retry" |

---

## Traceability Matrix — Use Cases ↔ Functional Requirements

| UC | FR-01 | FR-02 | FR-03 | FR-06 | FR-07 | FR-08 | FR-09 | FR-10 | FR-11 | FR-12 | FR-13 | FR-17 | FR-18 | FR-19 | FR-21 | FR-23 | FR-24 | FR-25 | FR-28 | FR-32 | FR-33 | FR-35 |
|----|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| UC-01 | ✓ | ✓ | ✓ | | | | | | | | | | | | | | | | | | | |
| UC-02 | | | ✓ | ✓ | ✓ | ✓ | ✓ | | | | | | | | | | | | | | | |
| UC-03 | | | ✓ | | | | | ✓ | ✓ | ✓ | ✓ | ✓ | | | | | | | | | | |
| UC-04 | | | ✓ | | | ✓ | ✓ | | | | | ✓ | ✓ | ✓ | ✓ | | | | | | | |
| UC-05 | | | ✓ | | | | | | | | | | | | | ✓ | ✓ | ✓ | | | | |
| UC-06 | | | ✓ | | | | | | | | | | | | | | | | ✓ | | | |
| UC-07 | | | ✓ | | | | | | | | | ✓ | | | | | | | | ✓ | ✓ | ✓ |

---

*Next: → [`03_uml_diagrams.md`](./03_uml_diagrams.md) — All Mermaid UML Diagrams*

