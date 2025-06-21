import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:io' show Platform;

class StepTrackerPage extends StatefulWidget {
  final bool isGuest;

  const StepTrackerPage({super.key, required this.isGuest});

  @override
  State<StepTrackerPage> createState() => _StepTrackerPageState();
}

class _StepTrackerPageState extends State<StepTrackerPage> {
  int _stepCount = 0;
  final int _stepGoal = 10000;
  StreamSubscription? _accelerometerSubscription;
  DateTime? _lastStepTime;

  @override
  void initState() {
    super.initState();
    if (!widget.isGuest) {
      loadSteps();
    }
    _initializeSensor();
  }

  Future<void> loadSteps() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _stepCount = prefs.getInt('daily_steps') ?? 0;
    });
  }

  Future<void> updateSteps(int steps) async {
    setState(() => _stepCount += steps);
    if (!widget.isGuest) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt('daily_steps', _stepCount);
    }
  }

  Future<void> resetSteps() async {
    setState(() => _stepCount = 0);
    if (!widget.isGuest) {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('daily_steps');
    }
  }

  void _initializeSensor() {
    if (!(Platform.isAndroid || Platform.isIOS)) return;

    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      final now = DateTime.now();
      if (_lastStepTime == null ||
          now.difference(_lastStepTime!) > const Duration(milliseconds: 700)) {
        // Basic threshold for step detection based on z-axis
        if (event.z > 12) {
          _lastStepTime = now;
          updateSteps(1);
        }
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_stepCount / _stepGoal).clamp(0.0, 1.0);
    final Color progressColor =
        progress < 0.2
            ? Colors.red
            : progress < 0.4
            ? Colors.orange
            : progress < 0.6
            ? Colors.yellow
            : progress < 0.8
            ? Colors.lightGreen
            : Colors.green;

    return Scaffold(
      appBar: AppBar(title: const Text('Step Tracker')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Today's Step Count", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 15,
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  Text(
                    '$_stepCount steps',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () => updateSteps(500),
                    child: const Text("+500 Steps"),
                  ),
                  ElevatedButton(
                    onPressed: () => updateSteps(1000),
                    child: const Text("+1000 Steps"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: resetSteps,
                child: const Text("Reset"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
