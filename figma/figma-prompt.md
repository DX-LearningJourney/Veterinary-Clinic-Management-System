# VetCare Pro — Figma Prototype Generation Prompt
## Complete UI/UX Specification for AI-Assisted Figma Design

> **HOW TO USE THIS FILE:**
> - **Figma AI / Make Designs:** Copy each screen spec section as a prompt
> - **Cursor / V0 / Locofy:** Use as full-context design brief
> - **Manual Figma:** Use as wireframe blueprint — layout, components, nav flow all defined here
> - **For Report:** This document serves as "User Interface Design" section input

---

## PART A — Project Identity & Brand

```
PROJECT NAME: VetCare Pro
TAGLINE: "Caring for pets, powered by technology"
APP TYPE: Multi-role web application (responsive, desktop-first)
DOMAIN: Veterinary Clinic Management System
TARGET DEVICE: Desktop browser (1440px primary), tablet (768px secondary)
```

### Color System

```
PRIMARY:      #2563EB  (Blue 600)    — trust, clinical, professional
PRIMARY DARK: #1D4ED8  (Blue 700)    — hover states, active
SECONDARY:    #059669  (Emerald 600) — health, success, active status
ACCENT:       #F59E0B  (Amber 500)   — warnings, pending states
DANGER:       #DC2626  (Red 600)     — errors, cancellations, critical alerts
NEUTRAL 50:   #F8FAFC                — page backgrounds
NEUTRAL 100:  #F1F5F9                — card backgrounds, sidebar
NEUTRAL 200:  #E2E8F0                — borders, dividers
NEUTRAL 500:  #64748B                — secondary text, icons
NEUTRAL 800:  #1E293B                — primary text, headings
WHITE:        #FFFFFF                — cards, modals
```

### Typography

```
FONT FAMILY:   Inter (Google Fonts)
HEADING H1:    32px / Bold / #1E293B
HEADING H2:    24px / SemiBold / #1E293B
HEADING H3:    20px / SemiBold / #1E293B
BODY LARGE:    16px / Regular / #1E293B
BODY NORMAL:   14px / Regular / #64748B
LABEL:         12px / Medium / #64748B
CAPTION:       11px / Regular / #94A3B8
```

### Component Design Tokens

```
BORDER RADIUS:  8px (cards), 6px (inputs/buttons), 4px (tags/badges), 50% (avatars)
SHADOW CARD:    0 1px 3px rgba(0,0,0,0.1), 0 1px 2px rgba(0,0,0,0.06)
SHADOW MODAL:   0 20px 60px rgba(0,0,0,0.15)
SPACING UNIT:   4px (use multiples: 4, 8, 12, 16, 20, 24, 32, 48, 64)
SIDEBAR WIDTH:  260px (expanded), 72px (collapsed)
TOPBAR HEIGHT:  64px
CONTENT MAX-W:  1200px
```

---

## PART B — User Roles & Access Map

| Role | Portal | Primary Color | Dashboard Focus |
|------|--------|--------------|----------------|
| **Pet Owner** | Customer Portal | Blue | My pets, upcoming appointments, reminders |
| **Veterinarian** | Clinical Portal | Emerald | Today's patients, pending records, vaccinations |
| **Receptionist** | Front Desk Portal | Blue | Calendar, check-in queue, billing |
| **Admin / Manager** | Admin Portal | Slate | Reports, user management, system config |

---

## PART C — Navigation Architecture

### Global Sidebar (Staff Roles)

```
TOP SECTION:
  [Logo: 🐾 VetCare Pro]
  [User Avatar + Name + Role Badge]

NAVIGATION ITEMS (icon + label):
  🏠 Dashboard
  📅 Appointments        [badge: pending count]
  🐾 Patients / Pets
  📋 Medical Records
  💉 Vaccinations
  💊 Prescriptions
  💵 Billing & Invoices
  📦 Inventory           [badge: low stock count]  ← Module K
  🗓️ Schedules           ← Module I
  🏷️ Service Catalog      ← Module J
  📊 Reports
  ⚙️ Settings

BOTTOM SECTION:
  [Notification Bell]    [badge: unread count]
  [Help / Docs]
  [Logout]
```

### Pet Owner Navigation (Top Nav Bar)

```
[🐾 VetCare Pro Logo]    [My Pets] [Appointments] [Medical Records] [Billing] [🔔] [Avatar ▾]
```

---

## PART D — Screen Inventory (Complete)

### AUTH SCREENS (2 screens)
```
SCR-001  Login Page
SCR-002  Forgot Password / Reset Password
```

### PET OWNER PORTAL (7 screens)
```
SCR-101  Pet Owner Dashboard
SCR-102  My Pets — Pet List
SCR-103  Pet Profile Detail + Medical History
SCR-104  Add / Edit Pet Profile (Form)
SCR-105  Book Appointment (Wizard — 3 steps)
SCR-106  My Appointments List
SCR-107  My Invoices & Billing History
```

### RECEPTIONIST PORTAL (6 screens)
```
SCR-201  Receptionist Dashboard
SCR-202  Appointment Calendar (Week View)
SCR-203  Create / Edit Appointment (Modal)
SCR-204  Patient Check-in Screen
SCR-205  Billing — Pending Invoices List
SCR-206  Invoice Detail + Payment Processing
```

### VETERINARIAN PORTAL (6 screens)
```
SCR-301  Veterinarian Dashboard (Today's Schedule)
SCR-302  Patient Examination Form (SOAP)
SCR-303  Medical Record Detail (Read View)
SCR-304  Issue Prescription (Form)
SCR-305  Record Vaccination (Form)
SCR-306  My Weekly Schedule View
```

### ADMIN / MANAGER PORTAL (7 screens)
```
SCR-401  Admin Dashboard & Analytics
SCR-402  User Management (List + Create/Edit Modal)
SCR-403  Service Catalog Management (Module J)
SCR-404  Medicine Catalog + Inventory Dashboard (Module K)
SCR-405  Stock-In / Adjustment Transaction Form (Module K)
SCR-406  Vet Schedule & Leave Management (Module I)
SCR-407  Reports — Revenue & Statistics
```

**Total Screens: 28**

---

## PART E — Individual Screen Specifications

---

### SCR-001 — Login Page

```
LAYOUT: Centered split-screen (50% brand panel | 50% form panel)

LEFT PANEL (brand):
  Background: gradient #1D4ED8 → #059669
  Content:
    - Large logo: 🐾 icon + "VetCare Pro" wordmark (white, 40px)
    - Tagline: "Caring for pets, powered by technology" (white, 18px)
    - 3 feature icons with labels:
        📅 "Online Appointment Booking"
        📋 "Digital Medical Records"
        💉 "Vaccination Tracking"
    - Decorative paw print watermark (bottom-right, 10% opacity white)

RIGHT PANEL (form):
  Background: #FFFFFF
  Top: VetCare Pro logo small (for mobile fallback)
  
  FORM ELEMENTS:
    Title: "Welcome Back" (H2)
    Subtitle: "Sign in to your account" (Body, gray)
    
    [Email Address label]
    [Email Input — placeholder: "doctor@vetcare.clinic"]
    
    [Password label]              [Forgot password? link — right aligned]
    [Password Input — type:password with show/hide toggle icon]
    
    [Remember me checkbox]
    
    [LOGIN Button — full width, primary blue, 48px height]
    
    Divider: "— or —"
    [Don't have an account? Register here link]
    
  BOTTOM: "© 2025 VetCare Pro. All rights reserved."

STATES TO DESIGN:
  - Default
  - Error (red border inputs + error message below)
  - Loading (spinner on button, button disabled)
```

---

### SCR-101 — Pet Owner Dashboard

```
LAYOUT: Top nav bar + main content area (no sidebar for pet owners)

TOP NAV: [Logo] [My Pets] [Appointments] [Medical Records] [Billing] [🔔 3] [Avatar: Jane D. ▾]

CONTENT SECTIONS:

  SECTION 1 — Welcome Banner
    "Good morning, Jane! 🌟"
    "You have 1 upcoming appointment tomorrow."
    [Book New Appointment Button — CTA]

  SECTION 2 — My Pets Quick View (horizontal scroll cards)
    Each Pet Card (200px wide):
      [Pet Photo/Avatar — 60px circle]
      Pet Name (bold)
      Species / Breed (small gray)
      Next Appointment: [date] or "No upcoming"
      Vaccination: [status badge — green OK / amber Due Soon / red Overdue]
      [View Profile button]

  SECTION 3 — Upcoming Appointments (list, max 3 shown)
    Each row:
      [Date+Time] [Vet Avatar] Dr. Name | [Pet Name] 🐕 | [Status Badge] | [Reschedule] [Cancel]
    [View All Appointments link]

  SECTION 4 — Vaccination Reminders (alert cards)
    Card style (amber border):
      ⚠️ "[Pet Name]'s [Vaccine Name] is due in 5 days"
      [Book Vaccination Appointment button]

  SECTION 5 — Recent Medical Records (last 2 visits)
    Each row: [Date] [Pet Name] [Dr. Name] [Diagnosis preview] [View Details →]
```

---

### SCR-105 — Book Appointment (3-Step Wizard)

```
LAYOUT: Centered card (max 680px wide) + step progress indicator at top

STEP INDICATOR:
  [● Step 1: Choose Pet & Service] — [○ Step 2: Select Date & Vet] — [○ Step 3: Confirm]

─────────────────────────────────
STEP 1: Choose Pet & Reason
─────────────────────────────────
  Title: "Which pet needs an appointment?"
  
  Pet Selection (radio cards, 2 per row):
    Each card: [Pet photo] [Name] [Species/Breed]
    Selected: blue border + blue checkmark
  
  [+ Add a new pet link]
  
  Service Type (dropdown):
    Options: General Consultation / Vaccination / Follow-up / Emergency / Other
  
  Reason for Visit (textarea, 3 rows):
    Placeholder: "Briefly describe the reason for this visit..."
  
  [Next → button — right aligned, disabled until pet + reason filled]

─────────────────────────────────
STEP 2: Select Date & Veterinarian  
─────────────────────────────────
  Title: "When would you like to come in?"
  
  Date Picker (inline calendar):
    - Disabled: past dates, dates with no vet availability (grayed out)
    - Highlighted: today, selected date (blue)
  
  After date selected → show below:
  
  Available Veterinarians & Slots:
    Each Vet Card:
      [Vet Avatar] Dr. [Name]
      Specialization: [tag]
      
      Time Slots (pill buttons, 2 rows):
        [09:00] [09:30] [10:00] [10:30] ...
        Green = available | Gray+line = taken
      
      Selected slot: highlighted blue pill
  
  [← Back]  [Next → button]

─────────────────────────────────
STEP 3: Review & Confirm
─────────────────────────────────
  Title: "Review your appointment"
  
  Summary Card (bordered, light blue bg):
    🐾 Pet:          [Pet name] ([Species])
    🩺 Veterinarian: Dr. [Name]
    📅 Date & Time:  [Full date] at [Time]
    📋 Reason:       [Reason text]
    🏥 Clinic:       VetCare Pro Clinic — 123 Main Street
  
  Notification Preference:
    [✓] Send me an email confirmation
    [✓] Remind me 24 hours before
  
  Note (gray): "You can reschedule or cancel up to 2 hours before your appointment."
  
  [← Back]  [Confirm Booking button — green, 48px]

─────────────────────────────────
SUCCESS STATE (after confirm):
─────────────────────────────────
  Centered:
    ✅ Large green checkmark icon (64px)
    "Appointment Confirmed!" (H2)
    "Reference: APT-2024-0042"
    Summary of booking
    [View My Appointments] [Book Another] buttons
```

---

### SCR-202 — Appointment Calendar (Receptionist)

```
LAYOUT: Sidebar + Header controls + Full-width calendar grid

HEADER BAR:
  [← Previous Week]  "Nov 4 – Nov 10, 2025"  [Next Week →]
  [Today button]  [View: Day | Week ▾]  [+ New Appointment button — blue]

CALENDAR GRID (7 columns for week view):
  Column headers: Mon 4 | Tue 5 | Wed 6 | Thu 7 | Fri 8 | Sat 9 | Sun 10
  Time rows: 08:00, 08:30, 09:00 ... 18:00 (30-min slots)
  
  Appointment Block (per slot):
    Color coded by vet (each vet gets distinct color)
    Block content:
      [Pet Name] 🐕
      [Vet initials badge]
      [Status dot: green=confirmed, amber=pending, red=cancelled]
    
    Click → appointment detail popup

APPOINTMENT DETAIL POPUP (modal on click):
  [Pet Owner] → [Pet Name]
  Vet: Dr. [Name]
  Time: [Start – End]
  Reason: [text]
  Status: [editable dropdown]
  [Edit] [Cancel Appointment] [Check In] [Close]

LEFT MINI PANEL (optional):
  Today's Stats:
    📅 Total today: 12
    ✅ Completed: 5
    ⏳ Pending: 4
    ❌ Cancelled: 1
    🚶 No-show: 2
  
  Filter by Vet: [checkboxes with color swatches per vet]
```

---

### SCR-204 — Patient Check-in Screen

```
LAYOUT: Full-screen focused workflow (minimal distractions)

HEADER: "Patient Check-In" | Today's date | [Search bar]

QUEUE TABLE:
  Columns: Time | Pet | Owner | Vet | Reason | Status | Actions
  Row states:
    - PENDING row: light yellow bg
    - CONFIRMED row: white bg  
    - CHECKED_IN row: light green bg
    - LATE (>15min past appointment): light red bg
  
  Action buttons per row:
    [Check In] → updates status to CHECKED_IN, notifies vet
    [View Details] → slide-out panel with full pet info

CHECK-IN SLIDE PANEL (right side, 400px):
  Pet photo + name (large)
  Owner: [Name] | Phone: [number]
  
  ⚠️ ALLERGY ALERT (if exists):
    Red banner: "Known allergies: [list]"
  
  Last Visit: [date] — [diagnosis preview]
  
  Vaccination Status:
    [✓ Rabies — current]  [⚠️ FVRCP — due in 3 days]
  
  [Confirm Check-in button — green, large]
  [Reschedule] [Cancel]
```

---

### SCR-302 — Veterinarian Examination Form (SOAP)

```
LAYOUT: Two-panel layout (left: patient info | right: SOAP form)

LEFT PANEL (340px — patient summary):
  [Pet Photo — 80px]
  Name: [Pet name]  [Species badge]
  DOB: [date] | Age: [X years Y months]
  Breed: [breed]
  Weight: [X kg]
  Owner: [Name] | [Phone]
  
  ⚠️ ALLERGY ALERT (red card if exists):
    [Allergen list]
  
  VACCINATION STATUS:
    [list with status indicators]
  
  PAST MEDICAL HISTORY (accordion):
    [Visit 1: date — diagnosis] ▾
    [Visit 2: date — diagnosis] ▾

RIGHT PANEL (SOAP Examination Form):
  Title: "New Examination — [Pet Name]"
  Date: [auto-filled today]  Vet: [auto-filled current user]
  
  ── VITAL SIGNS ────────────────────────
  [Weight: ___ kg]  [Temp: ___ °C]  [Heart Rate: ___ bpm]  [Resp Rate: ___ /min]
  
  ── S — SUBJECTIVE ─────────────────────
  Label: "Chief complaint (as described by owner)"
  [Textarea — 3 rows, placeholder: "Owner reports that the pet has been..."]
  
  ── O — OBJECTIVE ──────────────────────
  Label: "Physical examination findings"
  [Textarea — 4 rows, placeholder: "On physical examination..."]
  
  ── A — ASSESSMENT ─────────────────────
  Label: "Diagnosis"
  [+ Add Diagnosis button → opens inline row:]
    [Diagnosis name input] [ICD Code input] [Severity dropdown] [Primary? checkbox] [✕]
  [Diagnosis rows list]
  
  ── P — PLAN ───────────────────────────
  Label: "Treatment plan & follow-up instructions"
  [Textarea — 4 rows]
  
  ── ADDITIONAL NOTES ───────────────────
  [Textarea — 2 rows, optional]
  
  ACTIONS:
    [Save as Draft]  [Save & Issue Prescription →]  [Save & Record Vaccination →]  [Save & Done ✓]
```

---

### SCR-206 — Invoice Detail + Payment Processing

```
LAYOUT: Centered document view (max 860px) + right action panel

INVOICE HEADER:
  [VetCare Pro Logo]                    INVOICE
  123 Main Street, HCM City             INV-2024-0089
  Tel: 0900-000-000                     Issued: Nov 4, 2025
  
  BILLED TO:                            APPOINTMENT:
  [Owner Name]                          Pet: [Pet Name]
  [Owner Email]                         Vet: Dr. [Name]
  [Owner Phone]                         Date: Nov 3, 2025 10:00
                                        Record: MR-2024-0045

LINE ITEMS TABLE:
  | # | Description            | Category    | Qty | Unit Price | Subtotal |
  |---|------------------------|-------------|-----|------------|---------|
  | 1 | General Consultation   | Consultation|  1  | 150,000 đ  | 150,000 đ|
  | 2 | Blood Panel - CBC      | Lab Test    |  1  | 250,000 đ  | 250,000 đ|
  | 3 | Amoxicillin 500mg      | Medicine    |  2  |  45,000 đ  |  90,000 đ|
  | [+ Add Item button]  [pencil icon to edit each row]  [trash icon to remove]   |
  
  TOTALS:
    Subtotal:              490,000 đ
    Tax (0%):                    0 đ
    ─────────────────────────────
    TOTAL DUE:             490,000 đ

RIGHT ACTION PANEL (sticky, 280px):
  STATUS: [UNPAID badge — red]
  
  ──────────────────────────
  COLLECT PAYMENT
  ──────────────────────────
  Payment Method:
  [○ Cash]  [○ Bank Transfer]  [○ Card]
  
  Amount Received:
  [___________ đ  input]
  
  [Quick fill: 490,000 đ link]
  
  Change (if cash > total):
  [auto-calculated, green]
  
  [CONFIRM PAYMENT button — large, green]
  
  ──────────────────────────
  [Print Invoice PDF]
  [Email to Owner]
  [View Full History]
```

---

### SCR-403 — Service Catalog Management (Module J)

```
LAYOUT: Standard admin table view + slide-over form

PAGE HEADER:
  Title: "Service Catalog"
  Subtitle: "Manage clinic services and pricing"
  [+ Add New Service button — blue, top right]

FILTER BAR:
  [Search by name...]  [Category: All ▾]  [Status: Active ▾]  [Price range: ___ - ___]

SERVICES TABLE:
  Columns: Service Name | Category | Duration | Price | Status | Last Updated | Actions
  
  Row example:
  General Consultation | Consultation | 30 min | 150,000 đ | ● Active | Nov 1, 2025 | [Edit] [Deactivate]
  
  Category Badges (color coded):
    Consultation = Blue | Lab Test = Purple | Procedure = Orange
    Vaccination Service = Green | Grooming = Pink | Other = Gray
  
  Inactive rows: grayed out text + "Inactive" badge

ADD/EDIT SERVICE — SLIDE-OVER PANEL (right, 480px):
  Title: "Add New Service" / "Edit Service"
  
  Service Name*: [Input]
  Category*: [Dropdown — Consultation/Lab/Procedure/Vaccination Service/Grooming/Other]
  Description: [Textarea — 3 rows]
  Standard Price* (VND): [Number input with currency symbol]
  Estimated Duration: [Number input] minutes
  Active: [Toggle switch — ON/OFF]
  
  [Cancel]  [Save Service button]
  
  (Edit mode only):
    Price History section:
      Previous prices with change log (date, who changed, old → new)
```

---

### SCR-404 — Medicine Inventory Dashboard (Module K)

```
LAYOUT: Stats bar + filter + table + side panel

STATS CARDS (top row, 4 cards):
  [📦 Total Medicines: 48]
  [✅ In Stock: 41]  
  [⚠️ Low Stock: 5 — amber]
  [❌ Out of Stock: 2 — red]
  [🗓️ Expiring Soon (30d): 3 — amber]

ACTION BAR:
  [Search medicines...]  [Category: All ▾]  [Stock Status: All ▾]
  [+ Receive New Stock button — green]  [+ Adjust Stock button — amber]

INVENTORY TABLE:
  Columns: Medicine Name | Active Ingredient | Form | Stock | Min Threshold | Status | Expiry | Actions

  Row color coding:
    OK (stock > threshold): white bg
    LOW (stock ≤ threshold): amber-50 bg + ⚠️ icon
    OUT (stock = 0): red-50 bg + ❌ icon
    EXPIRING: orange dot in Expiry column

  Row example:
  Amoxicillin 500mg | Amoxicillin | Tablet | 42 units | 20 units | ● OK | Dec 2025 | [View] [Receive Stock] [Adjust]

STOCK-IN FORM (modal):
  Title: "Receive Stock — [Medicine Name]"
  Quantity Received*: [Number input]
  Batch Number*: [Input]
  Expiry Date*: [Date picker]
  Supplier Name: [Input]
  Unit Cost (VND): [Number input]
  Notes: [Textarea]
  [Cancel] [Save Stock Receipt]

ADJUSTMENT FORM (modal):
  Title: "Stock Adjustment — [Medicine Name]"
  Adjustment Type*: [Dropdown — EXPIRED / DAMAGED / RETURNED / CORRECTION]
  Quantity to Adjust*: [Number input — negative = reduce, positive = add]
  Reason/Notes*: [Textarea]
  [Cancel] [Save Adjustment]
```

---

### SCR-406 — Vet Schedule & Leave Management (Module I)

```
LAYOUT: Left vet list + right schedule view

LEFT PANEL (260px):
  Title: "Veterinary Staff"
  
  [Search vets...]
  
  Vet list (clickable rows):
    [Avatar] Dr. [Name]
    Specialization: [text]
    Status: [● Available / ● On Leave]

RIGHT PANEL (selected vet):
  HEADER:
    [Vet Avatar 48px] Dr. [Full Name]
    [Specialization badge] [License: VN-2021-0023]
    [Edit Schedule button]  [Add Leave button]

  TAB 1 — WEEKLY SCHEDULE:
    Table: Day | Working Hours | Break | Slot Duration | Status
    Mon | 08:00 – 17:00 | 12:00–13:00 | 30 min | ● Active
    Tue | 08:00 – 17:00 | 12:00–13:00 | 30 min | ● Active
    Wed | OFF            | —           | —      | ○ Day Off
    ...
    [Edit button per row]

  TAB 2 — LEAVE CALENDAR:
    Mini calendar view showing leaves marked in red
    
    Leave List:
    | Date Range | Type | Reason | Status | Actions |
    | Nov 10-12  | Sick | Flu    | ● Approved | [Cancel] |
    | Nov 20     | Annual | Personal | ⏳ Pending | [Approve] [Reject] |
    
    [+ Request Leave button]

ADD LEAVE MODAL:
  Veterinarian: [pre-filled, read-only]
  Leave Type*: [SICK / ANNUAL / EMERGENCY / OTHER]
  Start Date*: [Date picker]
  End Date*: [Date picker]
  Reason: [Textarea]
  [Cancel] [Submit Leave Request]
```

---

## PART F — Reusable Components Library

```
COMPONENT: Status Badge
  Variants: PENDING (amber), CONFIRMED (blue), CHECKED_IN (teal),
            IN_PROGRESS (purple), COMPLETED (green), CANCELLED (red),
            NO_SHOW (gray), CLOSED (slate)
  Size: small (px-2 py-0.5 text-xs), medium (px-3 py-1 text-sm)
  Style: rounded-full, font-medium, colored bg with matching text

COMPONENT: Pet Avatar Card (mini)
  [Circle photo/initials] [Name] [Species emoji] [Status badge]

COMPONENT: Data Table
  Sticky header, alternating row colors (#FFFFFF / #F8FAFC)
  Sortable columns (arrows), pagination (10/25/50 per page)
  Empty state: centered illustration + "No records found" text

COMPONENT: Form Slide-Over
  Width: 480px (standard) | 640px (complex forms)
  Overlay: black 40% opacity
  Header: title + X close button
  Body: scrollable
  Footer: [Cancel] [Primary Action] — sticky

COMPONENT: Confirmation Modal
  Icon: (warning ⚠️ or danger 🗑️)
  Title, body text, [Cancel] [Confirm — colored by action type]
  
COMPONENT: Toast Notification
  Position: bottom-right, stack up to 3
  Variants: Success (green), Error (red), Warning (amber), Info (blue)
  Auto-dismiss: 4s, manual X button

COMPONENT: Appointment Time Slot Pill
  Available: white bg, blue border, blue text — hover: blue fill
  Selected: blue fill, white text
  Taken: gray bg, gray text, line-through, no hover

COMPONENT: SOAP Section Accordion
  Header: colored left border + label + completion indicator (✓ / ○)
  Body: textarea + character count

COMPONENT: Alert / Allergy Banner
  Full-width, red bg, white text, warning icon
  Text: "⚠️ ALLERGY ALERT: [allergen list] — verify before prescribing"
```

---

## PART G — Navigation Flows

```
FLOW 1: Pet Owner — Book Appointment
Login → Dashboard → [Book New Appointment] → SCR-105 Step 1
→ Step 2 → Step 3 → Success → SCR-106 (My Appointments)

FLOW 2: Receptionist — Full Visit Cycle
SCR-201 → SCR-202 (Calendar) → [Check-in] SCR-204
→ [Notify Vet] → [Later: Billing] SCR-205 → SCR-206

FLOW 3: Veterinarian — Examine & Record
SCR-301 (Dashboard) → [Start Examination] SCR-302 (SOAP Form)
→ [Save & Issue Prescription] SCR-304
→ [Save & Record Vaccination] SCR-305

FLOW 4: Admin — Manage Service Catalog
SCR-401 (Dashboard) → [Service Catalog] SCR-403
→ [+ Add New Service] → Slide-over → Save → Back to SCR-403

FLOW 5: Admin — Manage Inventory
SCR-401 → [Inventory] SCR-404 → [Receive Stock] → Modal → Save
→ [Adjust Stock] → Modal → Save

FLOW 6: Admin — Vet Schedule Setup
SCR-401 → [Schedules] SCR-406 → Select Vet → Edit Schedule / Add Leave
```

---

## PART H — Figma File Structure Recommendation

```
PAGE 1: 🎨 Design System
  → Colors, Typography, Spacing, Icons, Components

PAGE 2: 🔐 Auth Screens
  → SCR-001 Login, SCR-002 Forgot Password

PAGE 3: 👤 Pet Owner Portal
  → SCR-101 through SCR-107

PAGE 4: 📋 Receptionist Portal
  → SCR-201 through SCR-206

PAGE 5: 🩺 Veterinarian Portal
  → SCR-301 through SCR-306

PAGE 6: ⚙️ Admin Portal
  → SCR-401 through SCR-407

PAGE 7: 🔗 Prototype Connections
  → All flows connected with arrows/transitions
  → Navigation: Smart Animate, dissolve transitions (300ms ease)
```

---

## PART I — Prototype Interaction Specs

```
TRANSITIONS (Figma Prototype):
  Screen-to-screen:  Smart Animate | Ease In-Out | 250ms
  Modal/Slide-over open: Move In from Right | 300ms
  Modal close:       Move Out to Right | 250ms
  Toast:             Slide up from bottom | 200ms
  Accordion expand:  Smart Animate | 200ms
  Step wizard next:  Move In from Right | 250ms
  Step wizard back:  Move In from Left | 250ms

HOVER STATES (in Figma):
  Buttons: darken 10% on hover, 2px lift shadow
  Table rows: neutral-50 bg on hover
  Time slot pills: color fill on hover
  Nav items: primary-50 bg + primary text on hover

LOADING STATES:
  Buttons: spinner icon replaces text, opacity 80%
  Tables: skeleton loading rows (gray animated shimmer)
  Calendar: skeleton grid
```

---

## PART J — Sample Data for Prototype

```
USERS / OWNERS:
  Jane Nguyen | jane@email.com | Pet Owner
  Dr. Minh Tran | minh@vetcare.clinic | Veterinarian — Small Animals
  Dr. Linh Le | linh@vetcare.clinic | Veterinarian — Surgery
  Receptionist: Hoa Pham | hoa@vetcare.clinic

PETS:
  Milo — Golden Retriever, Male, 3 years, 28kg | Owner: Jane Nguyen
    Allergy: ⚠️ Penicillin
  Luna — Persian Cat, Female, 2 years, 4.2kg | Owner: Jane Nguyen
  Max — Poodle, Male, 5 years, 7kg | Owner: David Tran

APPOINTMENTS (sample):
  APT-001: Milo → Dr. Minh Tran | Nov 4, 2025 09:00 | CONFIRMED | General Consultation
  APT-002: Luna → Dr. Linh Le | Nov 4, 2025 10:30 | CHECKED_IN | Vaccination
  APT-003: Max → Dr. Minh Tran | Nov 5, 2025 14:00 | PENDING | Follow-up

SERVICES:
  General Consultation: 150,000 đ | 30 min
  Vaccination (standard): 200,000 đ | 20 min
  Blood Panel - CBC: 250,000 đ | 15 min
  X-Ray: 350,000 đ | 20 min
  Dental Cleaning: 800,000 đ | 60 min

MEDICINES (inventory):
  Amoxicillin 500mg Tablet | Stock: 42 | Min: 20 | 45,000đ/unit
  Metronidazole 250mg Tablet | Stock: 8 | Min: 15 ⚠️ LOW | 30,000đ/unit
  Prednisolone 5mg Tablet | Stock: 0 | Min: 10 ❌ OUT | 55,000đ/unit
```

---

## Prompt Templates for Figma AI Tools

### Quick Prompt (for Figma AI Make Designs / FigJam):
```
Design a professional veterinary clinic management web application called "VetCare Pro".
Use Inter font, primary color #2563EB (blue), secondary #059669 (green).
Create a [SCREEN NAME] screen for [ROLE].
Include: [paste relevant screen spec from Part E above].
Style: clean, clinical, modern SaaS dashboard. Card-based layout with 8px border radius.
```

### Full Context Prompt (for V0, Lovable, Bolt):
```
Build a web UI screen for VetCare Pro, a veterinary clinic management system.

Tech: React + Tailwind CSS (or describe your target)
Role: [Pet Owner / Veterinarian / Receptionist / Admin]
Screen: [Screen name from Part D]

Design tokens:
- Primary: #2563EB, Secondary: #059669, Danger: #DC2626, Warning: #F59E0B
- Font: Inter, Radius: 8px cards / 6px inputs, Shadow: sm

Layout spec:
[Paste the relevant screen spec from Part E]

Components needed:
[Paste relevant components from Part F]

Sample data to populate:
[Paste relevant data from Part J]
```

---

*This file is the single source of truth for Figma prototype generation.*  
*Cross-reference: → [`02_use_cases.md`](../workflow/02_use_cases.md) | [`01_requirements.md`](../workflow/01_requirements.md)*

