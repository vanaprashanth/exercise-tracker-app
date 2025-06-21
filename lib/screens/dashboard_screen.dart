import 'package:flutter/material.dart';
import 'exercise_list.dart';
import 'insights_page.dart';
import 'history_page.dart';
import 'water_tracker_page.dart';
import 'step_tracker_page.dart';
import 'welcome_screen.dart';

class DashboardScreen extends StatelessWidget {
  final bool isGuest;

  const DashboardScreen({super.key, required this.isGuest});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        automaticallyImplyLeading: false,
        actions: [
          if (!isGuest)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  (route) => false,
                );
              },
            ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text("Exercise List"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExerciseListPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_drink),
            title: const Text("Water Intake"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WaterTrackerPage(isGuest: isGuest),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_walk),
            title: const Text("Step Tracking"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StepTrackerPage(isGuest: isGuest),
                ),
              );
            },
          ),
          if (!isGuest) ...[
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("My Insights"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InsightsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Workout History"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WorkoutHistoryPage()),
                );
              },
            ),
          ],
          if (isGuest)
            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Return to Welcome"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                );
              },
            ),
        ],
      ),
    );
  }
}
