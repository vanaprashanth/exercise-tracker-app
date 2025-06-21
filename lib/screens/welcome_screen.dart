import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';
import 'admin_debug_users_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              final success = await showDialog<bool>(
                context: context,
                builder: (context) => const _EmployeeLoginDialog(),
              );
              if (success == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminDebugUsersScreen(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
            label: const Text(
              "Employee Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed:
                () => showAboutDialog(
                  context: context,
                  applicationName: 'Smart Fitness Tracker',
                  applicationVersion: '1.0',
                  children: const [
                    Text(
                      "Developed by Saiprashanth Vana.\nTrack exercises, insights, steps, and hydration.",
                    ),
                  ],
                ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🏋️‍♂️ Welcome to Smart Fitness Tracker!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                icon: const Icon(Icons.login),
                label: const Text("Customer Login"),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                icon: const Icon(Icons.person_add),
                label: const Text("Register"),
              ),
              const SizedBox(height: 15),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  side: const BorderSide(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DashboardScreen(isGuest: true),
                    ),
                  );
                },
                icon: const Icon(Icons.explore),
                label: const Text("Continue as Guest"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmployeeLoginDialog extends StatefulWidget {
  const _EmployeeLoginDialog();

  @override
  State<_EmployeeLoginDialog> createState() => _EmployeeLoginDialogState();
}

class _EmployeeLoginDialogState extends State<_EmployeeLoginDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Employee Login"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: "Username"),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),
          if (error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(error, style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final username = _usernameController.text.trim();
            final password = _passwordController.text.trim();
            if (username == 'admin' && password == 'admin123') {
              Navigator.pop(context, true);
            } else {
              setState(() => error = "Invalid credentials");
            }
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
