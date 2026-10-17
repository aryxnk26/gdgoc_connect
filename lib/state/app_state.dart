import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/announcement.dart';
import '../models/event.dart';
import '../models/task.dart';
import '../models/team_member.dart';

class AppState extends ChangeNotifier {
  // Authentication Demo State
  bool _isAuthenticated = false;
  String _userName = 'Guest Developer';
  String _userRole = 'Campus Member';

  // Core Data
  List<Event> _events = [];
  List<CommunityTask> _tasks = [];
  List<Announcement> _announcements = [];
  List<TeamMember> _teamMembers = [];

  AppState() {
    _loadInitialMockData();
  }

  bool get isAuthenticated => _isAuthenticated;
  String get userName => _userName;
  String get userRole => _userRole;

  List<Event> get events => List.unmodifiable(_events);
  List<CommunityTask> get tasks => List.unmodifiable(_tasks);
  List<Announcement> get announcements => List.unmodifiable(_announcements);
  List<TeamMember> get teamMembers => List.unmodifiable(_teamMembers);

  void _loadInitialMockData() {
    _events = List.from(MockData.initialEvents);
    _tasks = List.from(MockData.initialTasks);
    _announcements = List.from(MockData.initialAnnouncements);
    _teamMembers = List.from(MockData.teamMembers);
  }

  void loginAsDemoUser({required String name, required String role}) {
    _isAuthenticated = true;
    _userName = name.trim().isEmpty ? 'GDG Contributor' : name.trim();
    _userRole = role;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _userName = 'Guest Developer';
    _userRole = 'Campus Member';
    notifyListeners();
  }

  void toggleEventRegistration(String eventId) {
    final index = _events.indexWhere((e) => e.id == eventId);
    if (index != -1) {
      final current = _events[index];
      final newStatus = !current.isUserRegistered;
      final newCount = newStatus
          ? current.registeredCount + 1
          : (current.registeredCount > 0 ? current.registeredCount - 1 : 0);

      _events[index] = current.copyWith(
        isUserRegistered: newStatus,
        registeredCount: newCount,
      );
      notifyListeners();
    }
  }

  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  int get upcomingEventsCount => _events.length;
  int get activeTasksCount =>
      _tasks.where((t) => t.status != TaskStatus.completed).length;
}

// InheritedProvider to supply AppState down the widget tree without external packages
class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    Key? key,
    required AppState notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'No AppStateScope found in context');
    return scope!.notifier!;
  }
}