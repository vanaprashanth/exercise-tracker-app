import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/log_storage.dart';
import '../models/user.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  int total = 0;
  int completed = 0;
  int skipped = 0;
  int duration = 0;

  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadInsights();
  }

  Future<void> loadInsights() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('current_user');
    if (username == null) return;

    final data = prefs.getStringList('user_$username');
    if (data == null || data.length < 5) return;

    setState(() {
      user = UserModel.fromList(username, data);
    });

    final logs = await LogStorage.fetchLogsForDate(DateTime.now());
    final completedLogs = logs.where((e) => !e.skipped).toList();
    final skippedLogs = logs.where((e) => e.skipped).toList();

    setState(() {
      total = logs.length;
      completed = completedLogs.length;
      skipped = skippedLogs.length;
      duration = logs.fold(0, (sum, e) => sum + e.duration);
    });
  }

  String formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    final hrs = mins ~/ 60;
    final minOnly = mins % 60;
    if (hrs > 0) return "$hrs hr $minOnly min";
    return "$minOnly min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Insights')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              '📈 Workout Summary (Today)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStatCard('Total Workouts', '$total', Icons.fitness_center),
            _buildStatCard(
              'Completed Exercises',
              '$completed',
              Icons.check_circle,
            ),
            _buildStatCard('Skipped Exercises', '$skipped', Icons.cancel),
            _buildStatCard(
              'Estimated Time Spent',
              formatDuration(duration),
              Icons.timer_outlined,
            ),
            const SizedBox(height: 30),
            const Text(
              '🧍 User Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (user != null) ...[
              ListTile(
                leading: const Icon(Icons.person),
                title: Text('Name: ${user!.name}'),
              ),
              ListTile(
                leading: const Icon(Icons.male),
                title: Text('Gender: ${user!.gender}'),
              ),
              ListTile(
                leading: const Icon(Icons.cake),
                title: Text('Age: ${user!.age}'),
              ),
              ListTile(
                leading: const Icon(Icons.monitor_weight),
                title: Text('Weight: ${user!.weight} kg'),
              ),
              ListTile(
                leading: const Icon(Icons.height),
                title: Text('Height: ${user!.height} cm'),
              ),
            ] else
              const Text(
                "No profile info found.",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
