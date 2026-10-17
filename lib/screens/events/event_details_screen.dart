import 'package:flutter/material.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/status_badge.dart';

class EventDetailsScreen extends StatelessWidget {
  final String eventId;

  const EventDetailsScreen({super.key, required this.eventId});

  String _formatFullDate(DateTime dt) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final minuteStr = dt.minute == 0 ? '00' : dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year} at $hour:$minuteStr $period';
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final eventIndex = state.events.indexWhere((e) => e.id == eventId);

    if (eventIndex == -1) {
      return Scaffold(
        appBar: AppBar(title: const Text('Event Not Found')),
        body: const Center(child: Text('This event is no longer available.')),
      );
    }

    final event = state.events[eventIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Overview'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatusBadge.fromCategory(event.category),
                const Spacer(),
                Icon(
                  event.isUserRegistered ? Icons.verified : Icons.radio_button_unchecked,
                  color: event.isUserRegistered ? AppTheme.googleGreen : Colors.grey,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  event.isUserRegistered ? 'Confirmed RSVP' : 'Open Registration',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: event.isUserRegistered ? AppTheme.googleGreen : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              event.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3),
            ),
            const SizedBox(height: 20),
            _buildMetaRow(Icons.calendar_today_outlined, 'Date & Time', _formatFullDate(event.dateTime)),
            const SizedBox(height: 14),
            _buildMetaRow(Icons.place_outlined, 'Location', event.venue),
            const SizedBox(height: 14),
            _buildMetaRow(Icons.person_pin_outlined, 'Speaker / Host', event.speaker),
            const SizedBox(height: 14),
            _buildMetaRow(Icons.group_outlined, 'Seat Availability', '${event.registeredCount} / ${event.capacity} seats filled'),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'About the Session',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: TextStyle(fontSize: 14, height: 1.6, color: Colors.grey.shade800),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Remember to bring your laptop and campus student ID for workshop accreditation.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF6B4E00)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: event.isUserRegistered ? AppTheme.googleRed : AppTheme.googleBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              state.toggleEventRegistration(event.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    event.isUserRegistered
                        ? 'Cancelled RSVP for ${event.title}'
                        : 'Registration confirmed! Check your campus email.',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(event.isUserRegistered ? Icons.cancel_outlined : Icons.check_circle_outline),
            label: Text(
              event.isUserRegistered ? 'Cancel RSVP' : 'Register for Session',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetaRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: const Color(0xFFE8F0FE),
          child: Icon(icon, size: 16, color: AppTheme.googleBlue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }
}