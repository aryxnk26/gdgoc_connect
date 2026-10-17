enum TaskPriority { high, medium, low }
enum TaskStatus { pending, inProgress, completed }

class CommunityTask {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskPriority priority;
  TaskStatus status;
  final String assignedRole;

  CommunityTask({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.status,
    required this.assignedRole,
  });

  CommunityTask copyWith({
    TaskStatus? status,
  }) {
    return CommunityTask(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      priority: priority,
      status: status ?? this.status,
      assignedRole: assignedRole,
    );
  }
}