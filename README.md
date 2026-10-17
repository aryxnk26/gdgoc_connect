# GDGoC Connect

**GDGoC Connect** is a mobile hub application engineered for Google Developer Groups on Campus (GDGoC). It provides students, organizers, and campus chapter leads with an intuitive workspace to discover upcoming sessions, track organizational tasks, and connect with their local campus developer ecosystem.

---

## 🌟 Key Features

1. **Clear Demo Authentication**:
   - Explicitly designed with a guest / demo login screen.
   - Allows customized demo profiles without claiming nonexistent Firebase/backend authentication.

2. **Interactive Home Dashboard**:
   - Welcome banner personalized with the logged-in demo role.
   - Quick activity counters for active events and open tasks.
   - Live pinned announcements and upcoming highlights.

3. **Events Hub with RSVP State**:
   - Real-time category filtering (Technical, Workshop, Hackathon, Social) and keyword search.
   - Detailed event specification view including speakers, venue, date/time, and capacity metrics.
   - Interactive RSVP / Registration toggle updating seat counts and state across screens.

4. **Task Tracker**:
   - Segmented tab views for Pending, In Progress, and Completed tasks.
   - Direct status updates via checkboxes and action menus.

5. **Community & Organizing Team Directory**:
   - Chapter lead showcase with roles and departments.
   - Community-wide announcements board.
   - Active profile view with session sign-out functionality.

---

## 🏗️ Architecture & Code Organization

The application strictly adopts standard Flutter patterns with zero extraneous dependencies:

- **State Management**: Implemented using pure Flutter `ChangeNotifier` coupled with `InheritedNotifier` (`AppStateScope`). This ensures reactive, predictable state transitions while maintaining high performance and testability.
- **Model Separation**: Isolated entities for `Event`, `CommunityTask`, `Announcement`, and `TeamMember`.
- **UI & Widgets**: Clean separation between screens and modular components (`EventCard`, `TaskTile`, `StatusBadge`, `SectionHeader`).
- **Styling**: Google Developer brand palette integrated into a Material 3 design system.

---

## 🚀 Setup & Execution Instructions

Ensure you have Flutter SDK installed (version >= 3.0.0).

1. Clone or extract the project repository:
   ```bash
   cd gdgoc_connect