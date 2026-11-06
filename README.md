# TWO — Admin & Operations Management Dashboard

The official web management dashboard for **TWO** (internally named *Team Work Organizer*). This central control panel serves as the operational command center for the agency's internal team—allowing administrators, project managers, and operational staff to track software projects, direct employee assignments, process incoming client project requests, generate and approve legal contracts, manage scheduled meetings, and monitor real-time company performance metrics.

---

## Table of Contents

* [Overview](https://www.google.com/search?q=%23overview)
* [Key Features](https://www.google.com/search?q=%23key-features)
* [System Workflow](https://www.google.com/search?q=%23system-workflow)
* [Tech Stack](https://www.google.com/search?q=%23tech-stack)
* [Architecture](https://www.google.com/search?q=%23architecture)
* [Directory Structure](https://www.google.com/search?q=%23directory-structure)
* [Navigation & Routes](https://www.google.com/search?q=%23navigation--routes)
* [Usage Guide](https://www.google.com/search?q=%23usage-guide)
* [Quality & Tooling](https://www.google.com/search?q=%23quality--tooling)
* [Localization](https://www.google.com/search?q=%23localization)
* [Production Checklist](https://www.google.com/search?q=%23production-checklist)
* [Known Limitations](https://www.google.com/search?q=%23known-limitations)

---

## Overview

The **TWO Dashboard** is built with Flutter Web to provide a high-efficiency desktop and web administration interface:

1. **Operations & Team Control**: Complete visibility over employee roles, workload allocation, administrative permissions, and team productivity.
2. **Project Lifecycle Management**: Full administrative authority over incoming project inquiries, active client projects, milestone progress, edit requests, and rating metrics.
3. **Contract Workflow Automation**: Interface to draft, review, approve, and send official legal project contracts to clients for electronic signature.
4. **Centralized Communication & Scheduling**: System to organize project meetings, manage notification triggers, and respond to client requests in real time.

The application leverages Clean Architecture, state management powered by BLoC, route handling via `go_router`, and service locator registration using `get_it`.

---

## Key Features

### Employee & Administrative Management

* View, add, update, and manage employee profiles and system credentials.
* Assign project managers, developers, and team members to specific active client projects.
* Monitor employee roles, contact information, and project allocation.

### Inbound Project Request & Lead Processing

* Receive, evaluate, and accept or reject detailed project requests submitted via the official client website.
* Review client-submitted specifications, feature scopes, and attached PDF reference materials.
* Convert approved inquiries directly into active project instances.

### Comprehensive Project Tracking

* Manage project status across lifecycle phases (Pending, In Progress, Review, Completed).
* Process client edit requests with history logs and team responses.
* Review client ratings and project evaluation scores.
* Control visibility settings and project detail configurations.

### Contract Operations & Digital Approval Flow

* Draft and generate contracts linked directly to specific project records.
* Multi-tier approval pipeline (Manager Approval, Project Manager Approval, Admin Signature).
* View contract PDFs, attach generated documents, and verify received client Base64 PNG signatures.

### Scheduling & Communication Engine

* Schedule, reschedule, and manage meetings between team members and clients.
* Send targeted and system-wide notifications to clients and staff members.
* Monitor unread alerts and system events.

### Analytics & System Overview

* Central dashboard showcasing key metrics: total projects, active contracts, pending requests, and team performance indicators.
* Quick action shortcuts for fast administrative tasks.

---

## System Workflow

```text
       Incoming Request (From Client Website)
                         │
                         ▼
             [ Admin Dashboard Review ]
                         │
        ┌────────────────┴────────────────┐
        │ Accept Request                  │ Reject Request
        ▼                                 ▼
Create Active Project Record      Archive Request & Notify Client
        │
        ├─► Assign Project Manager & Team Members
        │
        ├─► Issue & Approve Contract PDF
        │     │
        │     ├── Admin Signature / PM Approval
        │     └── Forward to Client App for E-Signature
        │
        ├─► Track Milestones, Edit Requests & Meetings
        │
        ▼
   Project Completion & Client Rating Review

```

---

## Tech Stack

| Category | Technology / Package | Version |
| --- | --- | --- |
| Framework | Flutter / Dart SDK (Web/Desktop) | Dart `^3.8.1` |
| State Management | `flutter_bloc`, `bloc` | `^9.1.1`, `^9.0.0` |
| Routing | `go_router` | `^16.1.0` |
| Dependency Injection | `get_it` | `^8.2.0` |
| Functional Error Handling | `dartz` | `^0.10.1` |
| HTTP Client | `http` | `^1.4.0` |
| Local Storage | `shared_preferences` | `^2.5.3` |
| Networking Utilities | `internet_connection_checker` | `^3.0.1` |
| Document Viewing | `syncfusion_flutter_pdfviewer` | `^27.1.48` |
| Document Engine | `syncfusion_flutter_pdf` | `^27.1.48` |
| Signature Utilities | `signature` | `^5.4.1` |
| File Selection | `file_picker` | `^10.2.1` |
| File System & Paths | `path_provider` | `^2.1.5` |
| UI & Vector Assets | `flutter_svg`, `iconsax` | `^2.2.0`, `^0.0.8` |
| Loading & Animations | `skeletonizer`, `lottie` | `^2.1.0+1`, `^3.3.1` |
| Linting | `flutter_lints` | `^5.0.0` |
| Typography | Poppins, Almarai | Bundled in `assets/fonts/` |

---

## Architecture

The codebase adheres to **layered Clean Architecture, structured feature-first**:

| Layer | Responsibility | Path |
| --- | --- | --- |
| Presentation | Data tables, detail views, administrative forms, sidebars | `lib/features/*/pages`, `lib/features/*/widgets` |
| Application / State | BLoC event processing and operational state management | `lib/features/app/bloc` |
| Domain | Use cases and business repository contracts | `lib/features/app/domain` |
| Data | Remote data sources, DTOs, API mappers, and repository implementations | `lib/features/app/data` |
| Core | API network handlers, standard exceptions, shared tables & inputs | `lib/core` |
| Config | Route configurations, system constants, themes, layout definitions | `lib/config` |
| Dependency Injection | Service locator setup | `lib/injection_container.dart` |

---

## Directory Structure

```text
two-dashboard/
├── assets/
│   ├── animation/                # Lottie operational state animations
│   ├── fonts/                    # Poppins and Almarai typography
│   ├── icons/                    # Dashboard navigation and action icons
│   ├── images/                   # Branding vectors and UI background assets
│   └── lang/                     # Translation catalog JSONs (EN / AR)
├── lib/
│   ├── config/
│   │   ├── constants/            # API base URIs, pagination defaults, padding
│   │   ├── paths/                # Centralized string keys and file paths
│   │   ├── routes/               # Declarative go_router configuration
│   │   └── theme/                # Dashboard theme data and dark/light palettes
│   ├── core/
│   │   ├── api/                  # Encapsulated HTTP client operations
│   │   ├── error/                # Exception handling and validation routines
│   │   ├── functions/            # UI status builders and helpers
│   │   ├── models/               # Operational DTO models
│   │   ├── network/              # Connectivity status monitoring
│   │   ├── param/                # Form request data structures
│   │   ├── services/             # Local web storage and token services
│   │   └── widgets/              # Reusable data tables, sidebars, metrics cards
│   ├── features/
│   │   ├── app/
│   │   │   ├── bloc/             # BLoC management for admin operations
│   │   │   ├── data/             # Remote datasource & repository implementations
│   │   │   └── domain/           # Operations use cases
│   │   ├── home/                 # Analytics overview & quick stats
│   │   ├── employees/            # Team management & role assignments
│   │   ├── project_requests/     # Inbound client request processing
│   │   ├── projects/             # Active project management & edit logs
│   │   ├── contracts/            # Contract creation, approvals, PDF viewing
│   │   ├── meetings/             # Scheduling & meeting management
│   │   └── profile/              # Admin account settings
│   ├── injection_container.dart # GetIt dependency injection registry
│   └── main.dart                 # Application entry point
├── web/                          # Web app wrapper and HTML entry configuration
├── pubspec.yaml
├── analysis_options.yaml
└── README.md

```

---

## Navigation & Routes

Navigation is configured declaratively using `go_router`:

| Path | Screen | Purpose |
| --- | --- | --- |
| `/dashboard` | Executive Overview | Metrics overview, active statistics, quick actions |
| `/employees` | Employee Management | Team member directory, registration, and role assignment |
| `/project-requests` | Inbound Inquiries | Review and process prospective project submissions |
| `/projects` | Active Projects | Master list of company projects and progress states |
| `/project-details` | Project Control Center | Milestone updates, edit request logs, team assignments |
| `/contracts` | Contract Management | Legal document drafting, approvals, and signature logs |
| `/meetings` | Schedule Center | Meeting creation, updates, and calendar views |
| `/profile` | Admin Settings | Profile configuration and security settings |

---

## Usage Guide

### Processing New Project Inquiries

1. Navigate to **Project Requests** from the admin sidebar.
2. Click on an inquiry card to inspect the description, requirements, and client attachments.
3. Select **Approve Request** to convert it into a active project, or **Reject** to send a formal response.

### Team Assignment & Project Execution

1. Open an active project from the **Projects** table.
2. Select **Assign Team** to delegate a Project Manager and assigned software engineers.
3. Track progress logs, schedule team/client meetings, and respond to client-submitted edit requests.

### Managing Contracts & Approvals

1. Access the **Contracts** module.
2. Generate a contract linked to a project, attach the terms PDF, and execute the **Admin Approval** step.
3. Monitor client signature status (Base64 PNG signature validation) once signed from the mobile app.

---

## Quality & Tooling

### Code Formatting

```bash
dart format .

```

### Static Analysis

```bash
flutter analyze

```

### Building for Web Deployment

```bash
flutter build web --release

```

---

## Localization

The dashboard supports dual-language operation:

* `assets/lang/en.json` — English (Default administrative interface)
* `assets/lang/ar.json` — Arabic

Translation keys are mapped across core components to ensure seamless switching between English and Arabic administrative views.

---

## Production Checklist

Before releasing into production:

* [ ] Configure production HTTPS REST API base URLs in `lib/config/constants/`.
* [ ] Ensure strict Role-Based Access Control (RBAC) validation is active on the backend endpoints.
* [ ] Restrict admin token lifetimes and store tokens securely in browser sessions.
* [ ] Optimize dashboard data tables with server-side pagination for large project histories.
* [ ] Deploy behind a secure web server domain with SSL enabled.

---

## Known Limitations

* **Backend Dependency**: Requires an operational administration backend REST API.
* **Desktop Focus**: Optimized primarily for desktop web browsers and tablet displays; not intended for small mobile screens.


