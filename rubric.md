# 📋 Grading Rubric — RAD Final Project
## Requirements Analysis & Design — Software Engineering

> **Submission Deadline:** Before 22:00, 18/11/2026  
> **Presentation:** 12–15 min demo + 5–8 min Q&A  
> **Total Score:** 100% (split: Report 30% + Demo/Presentation 70%)

---

## Rubric Table

| Criterion | CLO | Col. | Weight | Excellent (8.5–10) | Good (7.0–8.4) | Average (5.0–6.9) | Poor (0–4.9) |
|-----------|-----|------|--------|-------------------|----------------|-------------------|--------------|
| **Report Formatting** | CLO3 | 1 | **10%** (10/30) | Report is clearly structured and coherent; free of spelling/grammar errors; attractive, professional presentation. | Well structured, with a few minor spelling/grammar errors; acceptable formatting. | Fairly acceptable structure but with noticeable issues in formatting or language expression. | Poor structure, many spelling/grammar errors, unprofessional and unappealing presentation. |
| **Content / Quality — Analysis & Design Documentation** | CLO3, CLO4 | 1 | **20%** (20/30) | Fully meets **80–100%** of required report content (current-state survey, requirements specification, UML/ERD models, database design, UI design…); accurate analysis, logical solutions, demonstrating in-depth understanding. | Meets **70–80%** of the required content; generally accurate but missing some important elements. | Meets **50–70%** of required content; analysis lacks detail or depth. | Meets **less than 50%** of required content; incomplete analysis or poor solution/design. |
| **Content / Quality — UI / Prototype Demo** | CLO3, CLO4 | 2 | **10%** (10/70) | UI/prototype is **complete and faithful** to the specified design; clearly and coherently illustrates the main business flows; smooth user experience. | UI/prototype is fairly complete and faithful to the design, with a few minor rough spots or insignificant omissions. | UI/prototype reflects only part of the design, is missing many functions, or does not fully match the specification. | No UI/prototype, or one is provided but does not correctly reflect the specified design. |
| **Content / Quality — Java Implementation Demo** | CLO3, CLO4 | 2 | **10%** (10/70) | Implements and runs **≥ 80%** of the main functions in Java; correct business logic; no serious errors; clearly structured, readable code. | Implements and runs **70–80%** of the main functions; relatively stable; a few minor errors or code not entirely clear. | Implements and runs **50–70%** of the main functions; with errors or unstable execution. | Implements **less than 50%** of main functions; program has serious errors / does not run; or no Java product. |
| **Presentation Skills** | CLO5 | 2 | **10%** (10/70) | Confident, clear, engaging; maintains strong interaction with the audience throughout. | Confident and clear; at times lacking interaction with or engagement of the audience. | Fairly clear but lacking confidence and interaction with the audience. | Unclear presentation; lacking confidence; no interaction with the audience. |
| **Response to Questions** | CLO4, CLO5 | 2 | **20%** (20/70) | Answers **all questions** correctly and confidently; complete and thorough explanations. | Answers **more than 2/3** of questions correctly with reasonable confidence. | Answers **more than 1/2** of questions correctly but lacks depth. | Answers **less than 1/2** of questions correctly; poor or unconvincing explanations. |
| **Team Participation** | CLO3, CLO5 | 2 | **20%** (20/70) | **All members** contribute equally to the project work and the presentation. | About **80%** of members actively contribute. | About **60%** of members actively contribute. | Fewer than **40%** of members contribute or show effort within the group. |

---

## Score Breakdown Summary

| Component | Criteria | Max Points |
|-----------|----------|-----------|
| **Report (Col. 1)** | Report Formatting + Content/Quality – Documentation | 30 pts |
| **Demo & Presentation (Col. 2)** | UI/Prototype + Java Demo + Presentation + Q&A + Team | 70 pts |
| **TOTAL** | | **100 pts** |

---

## Section 3 — General Requirements

### 3.1 Mandatory Report Content

| # | Required Section | Notes |
|---|-----------------|-------|
| 1 | Cover page, inner cover page, table of contents, list of figures/tables, full page numbering | Formatting requirement |
| 2 | **Project introduction:** rationale for choosing the topic, objectives, system scope (in-scope / out-of-scope) | — |
| 3 | **Survey & current state description:** actual business operations, relevant stakeholders, current processes, problems/limitations | ⭐ Important |
| 4 | **Requirements identification & specification:** | ⭐ Important |
|   | → List of functional requirements — **at least 10–15**, each with ID (FR-01, FR-02…) | Min 10–15 FRs |
|   | → List of non-functional requirements: performance, security, scalability, usability, etc. | — |
|   | → Requirements prioritization table (MoSCoW or Must-have/Should-have/Could-have) | — |
| 5 | **Requirements modeling with UML:** | ⭐ Important |
|   | → Overall Use Case diagram + detailed specs of **at least 5–7** main use cases (actors, pre/postconditions, main/alt/exception flows) | Min 5–7 UCs |
|   | → Class Diagram **or** ERD (entities, attributes, relationships) | — |
|   | → Sequence Diagrams **or** Activity Diagrams for **at least 3** important use cases | Min 3 diagrams |
| 6 | **Database design:** relational schema (tables, PK/FK, constraints) + optional data dictionary | — |
| 7 | **User interface design:** wireframes/mockups for main screens + navigation flow explanation | — |
| 8 | **Plan/results of building the illustrative prototype** | See §3.2 |
| 9 | **Conclusion:** self-assessment, limitations, future development directions | — |
| 10 | **Appendix:** task assignment table (full name, student ID, tasks, contribution %, confirmation signature) | — |

---

### 3.2 Prototype / Demo Requirements

| Part | Weight | Requirement |
|------|--------|-------------|
| **UI / Prototype** | 10% | Build ≥ 1 prototype illustrating specified main use cases — interactive mockup (Figma) or working app interface; must correctly reflect UI design and business flows in the report |
| **Java Implementation Demo** | 10% | Implement and demonstrate **live** in Java (console / Swing / JavaFX / Spring…) **at least 3–5** main functions; program must **actually run** on machine during presentation; mockups are NOT a substitute |
| **Demo Script** | — | Prepare a demo script following selected use cases, with reasonable sample data for both UI prototype and Java program |
| **Source Code Submission** | — | Submit Java source code together with the report as `.zip` or repository link (GitHub/GitLab) |

---

### 3.3 Presentation Session Requirements

| Item | Requirement |
|------|-------------|
| **Duration** | 12–15 minutes presentation + demo; 5–8 minutes for Q&A |
| **Participation** | All group members must present (each responsible for ≥ 1 content part) and be present for Q&A |
| **Slides** | Concise and focused; do not read slides verbatim |
| **Q&A Topics** | Rationale for requirements/models chosen; design decisions; system scalability; individual member contributions |

---

### 3.4 Formatting & Submission Requirements

| Item | Requirement |
|------|-------------|
| **Font** | Times New Roman, 13pt |
| **Spacing** | 1.5 line spacing, standard margins |
| **Language** | Free of spelling/grammar errors |
| **File Format** | Word `.docx` and/or PDF — submit via e-learning system |
| **Deadline** | **Before 22:00, 18/11/2026** — late submissions not accepted |
| **Also Submit** | Presentation slides + Java source code (zip or repo link) + UI prototype link/file |
| **References** | Clearly declare all references (documents, templates, images, libraries/frameworks used) |
