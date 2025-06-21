import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/exercise_list.dart';
import 'screens/insights_page.dart';
import 'screens/history_page.dart';
import 'screens/water_tracker_page.dart';
import 'screens/step_tracker_page.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Fitness Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true, // Modern material styling (optional)
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final args = settings.arguments;

        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const WelcomeScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/dashboard':
            return MaterialPageRoute(
              builder: (_) => DashboardScreen(isGuest: args as bool? ?? false),
            );
          case '/exercises':
            return MaterialPageRoute(builder: (_) => const ExerciseListPage());
          case '/insights':
            return MaterialPageRoute(builder: (_) => const InsightsPage());
          case '/history':
            return MaterialPageRoute(
              builder: (_) => const WorkoutHistoryPage(),
            );
          case '/water':
            return MaterialPageRoute(
              builder: (_) => WaterTrackerPage(isGuest: args as bool? ?? false),
            );
          case '/steps':
            return MaterialPageRoute(
              builder: (_) => StepTrackerPage(isGuest: args as bool? ?? false),
            );
          default:
            return MaterialPageRoute(
              builder:
                  (_) => const Scaffold(
                    body: Center(child: Text("Unknown route")),
                  ),
            );
        }
      },
    );
  }
}
