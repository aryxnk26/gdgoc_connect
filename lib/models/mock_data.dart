import '../models/event.dart';
import '../models/task.dart';
import '../models/announcement.dart';
import '../models/team_member.dart';

class MockData {
  static List<Event> initialEvents = [
    Event(
      id: 'e1',
      title: 'Flutter Forward: Responsive UI Masterclass',
      description:
          'Deep dive into building adaptive, stateful Flutter mobile and web apps with clean Material 3 standards.',
      dateTime: DateTime.now().add(const Duration(days: 2, hours: 3)),
      venue: 'CS Seminar Hall B & Streamed on Meet',
      speaker: 'Ananya Sharma (GDE Flutter)',
      category: EventCategory.workshop,
      capacity: 120,
      registeredCount: 88,
      isUserRegistered: true,
    ),
    Event(
      id: 'e2',
      title: 'Cloud & Kubernetes Hands-On Workshop',
      description:
          'Learn to containerize microservices and deploy clusters on Google Cloud Platform with live guided labs.',
      dateTime: DateTime.now().add(const Duration(days: 6, hours: 5)),
      venue: 'Innovation Lab 2',
      speaker: 'Rohan Verma (Cloud Architect)',
      category: EventCategory.technical,
      capacity: 80,
      registeredCount: 76,
      isUserRegistered: false,
    ),
    Event(
      id: 'e3',
      title: 'Solution Challenge 2026 Hack Day',
      description:
          'Collaborate on high-impact projects addressing the 17 UN Sustainable Development Goals using Google tech.',
      dateTime: DateTime.now().add(const Duration(days: 14)),
      venue: 'Campus Tech Park Auditorium',
      speaker: 'Core Team Leads',
      category: EventCategory.hackathon,
      capacity: 200,
      registeredCount: 142,
      isUserRegistered: false,
    ),
    Event(
      id: 'e4',
      title: 'Open Source Networking & Mixer',
      description:
          'Casual evening meetup for new GDGoC members, peer project showcases, and mentorship matchmaking.',
      dateTime: DateTime.now().add(const Duration(days: 20)),
      venue: 'Student Activity Lounge',
      speaker: 'GDGoC Leads & Mentors',
      category: EventCategory.social,
      capacity: 60,
      registeredCount: 45,
      isUserRegistered: false,
    ),
  ];

  static List<CommunityTask> initialTasks = [
    CommunityTask(
      id: 't1',
      title: 'Finalize RSVP List for Flutter Masterclass',
      description: 'Audit registered participants and issue email check-in QR codes.',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      assignedRole: 'Operations',
    ),
    CommunityTask(
      id: 't2',
      title: 'Review Solution Challenge Project Proposals',
      description: 'Score submitted briefs against feasibility and alignment with UN SDGs.',
      dueDate: DateTime.now().add(const Duration(days: 4)),
      priority: TaskPriority.medium,
      status: TaskStatus.pending,
      assignedRole: 'Tech Evaluation',
    ),
    CommunityTask(
      id: 't3',
      title: 'Prepare Social Media Kit for Cloud Study Jam',
      description: 'Draft banners and announcement copies for LinkedIn and Instagram.',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: TaskPriority.low,
      status: TaskStatus.pending,
      assignedRole: 'Design & Outreach',
    ),
    CommunityTask(
      id: 't4',
      title: 'Book Innovation Lab and Projectors',
      description: 'Submit administrative permission letter to university estates dept.',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      priority: TaskPriority.high,
      status: TaskStatus.completed,
      assignedRole: 'Logistics',
    ),
  ];

  static List<Announcement> initialAnnouncements = [
    Announcement(
      id: 'a1',
      title: 'Solution Challenge 2026 Registrations Open!',
      content:
          'Form teams of up to 4 members. Selected teams will receive dedicated mentorship and Google Cloud credits.',
      date: DateTime.now().subtract(const Duration(hours: 5)),
      author: 'GDGoC Campus Lead',
      isPinned: true,
    ),
    Announcement(
      id: 'a2',
      title: 'Venue Change for Tech Talk',
      content:
          'Please note the Kubernetes session on Friday will now be held in Innovation Lab 2 due to AV upgrades.',
      date: DateTime.now().subtract(const Duration(days: 1)),
      author: 'Operations Team',
      isPinned: false,
    ),
  ];

  static List<TeamMember> teamMembers = [
    const TeamMember(
      id: 'tm1',
      name: 'Aditi Deshmukh',
      role: 'GDGoC Campus Lead',
      department: 'Computer Science',
      initials: 'AD',
    ),
    const TeamMember(
      id: 'tm2',
      name: 'Siddharth Nair',
      role: 'Technical Lead',
      department: 'Information Tech',
      initials: 'SN',
    ),
    const TeamMember(
      id: 'tm3',
      name: 'Pooja Hegde',
      role: 'Design & UI/UX Lead',
      department: 'Digital Media',
      initials: 'PH',
    ),
    const TeamMember(
      id: 'tm4',
      name: 'Varun Rao',
      role: 'Events & Operations',
      department: 'Software Engineering',
      initials: 'VR',
    ),
  ];
}