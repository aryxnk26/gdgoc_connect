import 'package:flutter/material.dart';
import '../models/event.dart';
import '../theme/app_theme.dart';
import 'status_badge.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final VoidCallback onToggleRegister;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onToggleRegister,
  });

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final minuteStr = dt.minute == 0 ? '00' : dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    return '${months[dt.month - 1]} ${dt.day}, $hour:$minuteStr $period';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusBadge.fromCategory(event.category),
                  Text(
                    '${event.registeredCount}/${event.capacity} RSVPs',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF202124),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(event.dateTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.place_outlined, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.venue,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: AppTheme.googleBlue.withValues(alpha: 0.2),
                        child: const Icon(Icons.person, size: 14, color: AppTheme.googleBlue),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event.speaker,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: onToggleRegister,
                    style: OutlinedButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      side: BorderSide(
                        color: event.isUserRegistered
                            ? AppTheme.googleGreen
                            : AppTheme.googleBlue,
                      ),
                      backgroundColor: event.isUserRegistered
                          ? const Color(0xFFE6F4EA)
                          : Colors.transparent,
                    ),
                    icon: Icon(
                      event.isUserRegistered ? Icons.check_circle : Icons.bookmark_add_outlined,
                      size: 16,
                      color: event.isUserRegistered
                          ? AppTheme.googleGreen
                          : AppTheme.googleBlue,
                    ),
                    label: Text(
                      event.isUserRegistered ? 'Registered' : 'RSVP',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: event.isUserRegistered
                            ? AppTheme.googleGreen
                            : AppTheme.googleBlue,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}