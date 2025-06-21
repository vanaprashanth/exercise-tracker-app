import 'package:flutter/material.dart';

class WorkoutSummaryPage extends StatelessWidget {
  const WorkoutSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workout Summary")),
      body: const Center(
        child: Text(
          "Workout Summary will be shown here.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
