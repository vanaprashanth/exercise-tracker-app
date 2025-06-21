import 'package:flutter/material.dart';
import '../models/log.dart';
import '../utils/log_storage.dart';

class WorkoutHistoryPage extends StatefulWidget {
  const WorkoutHistoryPage({super.key});

  @override
  State<WorkoutHistoryPage> createState() => _WorkoutHistoryPageState();
}

class _WorkoutHistoryPageState extends State<WorkoutHistoryPage> {
  List<WorkoutLog> _logs = [];

  @override
  void initState() {
    super.initState();
    loadWorkoutHistory();
  }

  Future<void> loadWorkoutHistory() async {
    final logs = await LogStorage.fetchLogs();
    logs.sort((a, b) => b.date.compareTo(a.date)); // newest first
    setState(() => _logs = logs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Workout History")),
      body:
          _logs.isEmpty
              ? const Center(child: Text("No workout history found."))
              : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        log.exerciseName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        log.skipped
                            ? "Skipped"
                            : log.duration > 0
                            ? "${log.sets} sets | ${log.duration}s"
                            : "${log.sets} sets | ${log.reps} reps",
                      ),
                      trailing: Text(
                        "${log.date.year}-${log.date.month.toString().padLeft(2, '0')}-${log.date.day.toString().padLeft(2, '0')} "
                        "${log.date.hour.toString().padLeft(2, '0')}:${log.date.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
