import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  factory StatusBadge.fromCategory(EventCategory category) {
    switch (category) {
      case EventCategory.technical:
        return const StatusBadge(
          label: 'Technical',
          backgroundColor: Color(0xFFE8F0FE),
          textColor: AppTheme.googleBlue,
        );
      case EventCategory.workshop:
        return const StatusBadge(
          label: 'Workshop',
          backgroundColor: Color(0xFFE6F4EA),
          textColor: AppTheme.googleGreen,
        );
      case EventCategory.hackathon:
        return const StatusBadge(
          label: 'Hackathon',
          backgroundColor: Color(0xFFFEF7E0),
          textColor: Color(0xFFB06000),
        );
      case EventCategory.social:
        return const StatusBadge(
          label: 'Social',
          backgroundColor: Color(0xFFFCE8E6),
          textColor: AppTheme.googleRed,
        );
    }
  }

  factory StatusBadge.fromTaskPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return const StatusBadge(
          label: 'High Priority',
          backgroundColor: Color(0xFFFCE8E6),
          textColor: AppTheme.googleRed,
        );
      case TaskPriority.medium:
        return const StatusBadge(
          label: 'Medium Priority',
          backgroundColor: Color(0xFFFEF7E0),
          textColor: Color(0xFFB06000),
        );
      case TaskPriority.low:
        return const StatusBadge(
          label: 'Low Priority',
          backgroundColor: Color(0xFFE6F4EA),
          textColor: AppTheme.googleGreen,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}