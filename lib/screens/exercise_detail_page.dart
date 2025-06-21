import 'dart:async';
import 'package:flutter/material.dart';
import '../models/log.dart';
import '../utils/log_storage.dart';

class ExerciseDetailPage extends StatefulWidget {
  final String exerciseName;
  final bool isTimed;
  final int initialReps;
  final int initialSets;
  final int durationSeconds;
  final String imagePath;

  const ExerciseDetailPage({
    super.key,
    required this.exerciseName,
    required this.isTimed,
    required this.initialReps,
    required this.initialSets,
    required this.durationSeconds,
    required this.imagePath,
  });

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  late int _reps;
  late int _sets;
  late int _duration;
  late int _timeLeft;
  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _reps = widget.initialReps;
    _sets = widget.initialSets;
    _duration = widget.durationSeconds;
    _timeLeft = _duration;
  }

  void startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        stopTimer();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _timeLeft = _duration;
    });
  }

  void logWorkout(bool isSkipped) async {
    final log = WorkoutLog(
      exerciseName: widget.exerciseName,
      date: DateTime.now(),
      sets: _sets,
      reps: _reps,
      duration: _duration,
      skipped: isSkipped,
    );
    await LogStorage.saveWorkoutLog(log);
    if (!mounted) return;
    Navigator.pop(context, {'completed': !isSkipped});
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.exerciseName)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.imagePath.isNotEmpty)
                Image.asset(
                  widget.imagePath,
                  height: 180,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (_, __, ___) =>
                          const Icon(Icons.image_not_supported, size: 80),
                ),
              const SizedBox(height: 24),

              const Text(
                "Select Sets:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DropdownButton<int>(
                value: _sets,
                onChanged: (val) => setState(() => _sets = val!),
                items:
                    List.generate(10, (i) => i + 1)
                        .map(
                          (e) => DropdownMenuItem(value: e, child: Text('$e')),
                        )
                        .toList(),
              ),

              if (!widget.isTimed) ...[
                const SizedBox(height: 16),
                const Text(
                  "Select Reps:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<int>(
                  value: _reps,
                  onChanged: (val) => setState(() => _reps = val!),
                  items:
                      List.generate(30, (i) => i + 1)
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text('$e')),
                          )
                          .toList(),
                ),
              ] else ...[
                const SizedBox(height: 16),
                const Text(
                  "Select Duration (seconds):",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButton<int>(
                  value: _duration,
                  onChanged:
                      (val) => setState(() {
                        _duration = val!;
                        _timeLeft = _duration;
                      }),
                  items:
                      [15, 30, 45, 60, 90]
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text('$e')),
                          )
                          .toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  "Time Left: $_timeLeft s",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: startTimer,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Start"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: pauseTimer,
                      icon: const Icon(Icons.pause),
                      label: const Text("Pause"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: stopTimer,
                      icon: const Icon(Icons.stop),
                      label: const Text("Stop"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text("Complete"),
                onPressed: () => logWorkout(false),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.skip_next),
                label: const Text("Skip"),
                onPressed: () => logWorkout(true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
