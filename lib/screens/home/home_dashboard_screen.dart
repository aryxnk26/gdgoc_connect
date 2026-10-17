import 'package:flutter/material.dart';
import '../../models/announcement.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/event_card.dart';
import '../../widgets/section_header.dart';
import '../events/event_details_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  final ValueChanged<int> onNavigateTab;

  const HomeDashboardScreen({super.key, required this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final events = state.events;
    final announcements = state.announcements;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.googleBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.hub_outlined, color: AppTheme.googleBlue, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('GDGoC Campus'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'View Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => onNavigateTab(3), // Navigate to Community/Profile
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Mock pull-to-refresh
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _buildWelcomeCard(state),
            const SizedBox(height: 16),
            _buildQuickStatMetrics(context, state),
            const SizedBox(height: 16),
            SectionHeader(
              title: 'Pinned Announcements',
              actionLabel: 'See Community',
              onActionPressed: () => onNavigateTab(3),
            ),
            ...announcements.take(2).map((a) => _buildAnnouncementCard(a)),
            const SizedBox(height: 16),
            SectionHeader(
              title: 'Upcoming Events',
              actionLabel: 'View All',
              onActionPressed: () => onNavigateTab(1),
            ),
            if (events.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text('No upcoming events currently scheduled.'),
                ),
              )
            else
              ...events.take(2).map((e) => EventCard(
                    event: e,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailsScreen(eventId: e.id),
                        ),
                      );
                    },
                    onToggleRegister: () => state.toggleEventRegistration(e.id),
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(AppState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, ${state.userName} 👋',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Role: ${state.userRole}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Explore upcoming technical sessions, track campus activities, and build solutions with your local Google Developer Group.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatMetrics(BuildContext context, AppState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricTile(
              label: 'Upcoming Events',
              value: '${state.upcomingEventsCount}',
              icon: Icons.event,
              color: AppTheme.googleBlue,
              onTap: () => onNavigateTab(1),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildMetricTile(
              label: 'Open Tasks',
              value: '${state.activeTasksCount}',
              icon: Icons.checklist_rtl_rounded,
              color: AppTheme.googleGreen,
              onTap: () => onNavigateTab(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF202124),
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(Announcement item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.push_pin, size: 14, color: AppTheme.googleRed),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              item.content,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
            ),
            const SizedBox(height: 8),
            Text(
              'Posted by ${item.author}',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}