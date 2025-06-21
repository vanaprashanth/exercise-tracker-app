import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _weight = TextEditingController();
  final _height = TextEditingController();
  String? _gender;
  String errorMessage = '';
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  Future<bool> isUsernameTaken(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_$username');
  }

  bool isValidPassword(String value) {
    final regex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,32}$',
    );
    return regex.hasMatch(value);
  }

  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate() || _gender == null) return;

    final username = _username.text.trim();
    final prefs = await SharedPreferences.getInstance();

    if (await isUsernameTaken(username)) {
      setState(() => errorMessage = 'Username already exists!');
      return;
    }

    final user = UserModel(
      username: username,
      name: _name.text.trim(),
      gender: _gender!,
      age: _age.text.trim(),
      weight: _weight.text.trim(),
      height: _height.text.trim(),
    );

    await prefs.setStringList('user_${user.username}', [
      ...user.toList(),
      _password.text.trim(),
    ]);
    await prefs.setString('current_user', user.username);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen(isGuest: false)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Fill your details", style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _username,
                decoration: const InputDecoration(labelText: "Username"),
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: _password,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed:
                        () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  if (!isValidPassword(val)) {
                    return "Password must be 8–32 chars, include\nuppercase, digit, and special char.";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPassword,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed:
                        () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator:
                    (val) =>
                        val != _password.text ? "Passwords do not match" : null,
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator:
                    (val) =>
                        val == null || val.trim().isEmpty ? "Required" : null,
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                items:
                    ["Male", "Female", "Other"]
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                onChanged: (val) => setState(() => _gender = val),
                decoration: const InputDecoration(labelText: "Gender"),
                validator: (_) => _gender == null ? "Required" : null,
              ),
              TextFormField(
                controller: _age,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (val) => _validateNumeric(val, "Age"),
              ),
              TextFormField(
                controller: _weight,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Weight (kg)"),
                validator: (val) => _validateNumeric(val, "Weight"),
              ),
              TextFormField(
                controller: _height,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Height (cm)"),
                validator: (val) => _validateNumeric(val, "Height"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: const Text("Register"),
              ),
              const SizedBox(height: 10),
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateNumeric(String? value, String label) {
    if (value == null || value.trim().isEmpty) return "$label is required";
    if (int.tryParse(value.trim()) == null) return "$label must be a number";
    return null;
  }
}
