import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class WaterTrackerPage extends StatefulWidget {
  final bool isGuest;
  const WaterTrackerPage({super.key, required this.isGuest});

  @override
  State<WaterTrackerPage> createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  int _waterIntake = 0;
  final int _goal = 3000;
  String _todayKey = '';

  @override
  void initState() {
    super.initState();
    _todayKey = _generateTodayKey();
    if (!widget.isGuest) loadWaterIntake();
  }

  String _generateTodayKey() {
    final now = DateTime.now();
    return "water_${now.year}-${now.month}-${now.day}";
  }

  Future<void> loadWaterIntake() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _waterIntake = prefs.getInt(_todayKey) ?? 0;
    });
  }

  Future<void> updateWaterIntake(int ml) async {
    if (widget.isGuest) {
      setState(() => _waterIntake += ml);
    } else {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _waterIntake += ml;
        prefs.setInt(_todayKey, _waterIntake);
      });
    }
  }

  Future<void> resetWaterIntake() async {
    if (widget.isGuest) {
      setState(() => _waterIntake = 0);
    } else {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _waterIntake = 0;
        prefs.remove(_todayKey);
      });
    }
  }

  Color _getProgressColor(double percent) {
    if (percent >= 1.0) return Colors.green[800]!;
    if (percent >= 0.8) return Colors.green[400]!;
    if (percent >= 0.6) return Colors.yellow[700]!;
    if (percent >= 0.4) return Colors.orangeAccent;
    if (percent >= 0.2) return Colors.redAccent;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_waterIntake / _goal).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
        leading:
            widget.isGuest
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Today's Water Intake",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[300],
                      color: _getProgressColor(progress),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        '$_waterIntake ml',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Goal: $_goal ml',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () => updateWaterIntake(200),
                    child: const Text("+200 ml"),
                  ),
                  ElevatedButton(
                    onPressed: () => updateWaterIntake(500),
                    child: const Text("+500 ml"),
                  ),
                  ElevatedButton(
                    onPressed: () => updateWaterIntake(1000),
                    child: const Text("+1 Litre"),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: resetWaterIntake,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Reset"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
