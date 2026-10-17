import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../state/app_state.dart';
import '../../widgets/task_tile.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final allTasks = state.tasks;

    final pending = allTasks.where((t) => t.status == TaskStatus.pending).toList();
    final inProgress = allTasks.where((t) => t.status == TaskStatus.inProgress).toList();
    final completed = allTasks.where((t) => t.status == TaskStatus.completed).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Tasks'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabs: [
            Tab(text: 'Pending (${pending.length})'),
            Tab(text: 'Active (${inProgress.length})'),
            Tab(text: 'Done (${completed.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTaskList(pending, state, 'No pending tasks left! Good job.'),
          _buildTaskList(inProgress, state, 'No tasks currently marked in progress.'),
          _buildTaskList(completed, state, 'No completed tasks yet.'),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<CommunityTask> tasks, AppState state, String emptyMsg) {
    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_turned_in_outlined, size: 54, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              emptyMsg,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(
          task: task,
          onStatusChanged: (newStatus) {
            state.updateTaskStatus(task.id, newStatus);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Updated "${task.title}" status.'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}