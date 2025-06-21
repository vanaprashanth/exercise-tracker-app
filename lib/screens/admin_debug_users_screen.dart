import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminDebugUsersScreen extends StatefulWidget {
  const AdminDebugUsersScreen({super.key});

  @override
  State<AdminDebugUsersScreen> createState() => _AdminDebugUsersScreenState();
}

class _AdminDebugUsersScreenState extends State<AdminDebugUsersScreen> {
  List<Map<String, String>> userProfiles = [];

  @override
  void initState() {
    super.initState();
    fetchUserProfiles();
  }

  Future<void> fetchUserProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final users = keys.where((key) => key.startsWith('user_'));

    final profiles = <Map<String, String>>[];
    for (final userKey in users) {
      final username = userKey.replaceFirst('user_', '');
      final values = prefs.getStringList(userKey);

      if (values != null && values.length >= 6) {
        profiles.add({
          'Username': username,
          'Name': values[0],
          'Gender': values[1],
          'Age': values[2],
          'Weight': values[3],
          'Height': values[4],
          'Password': '••••••••',
        });
      }
    }

    setState(() {
      userProfiles = profiles;
    });
  }

  Future<void> deleteUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_$username');

    final current = prefs.getString('current_user');
    if (current == username) {
      await prefs.remove('current_user');
    }

    fetchUserProfiles(); // Refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registered Users")),
      body:
          userProfiles.isEmpty
              ? const Center(child: Text("No users found."))
              : ListView.builder(
                itemCount: userProfiles.length,
                itemBuilder: (context, index) {
                  final user = userProfiles[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ExpansionTile(
                      title: Text(user['Username'] ?? ''),
                      children: [
                        ...user.entries.map(
                          (entry) => ListTile(
                            title: Text("${entry.key}: ${entry.value}"),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: const Text("Delete User"),
                                    content: Text(
                                      "Are you sure you want to delete '${user['Username']}'?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.pop(ctx, false),
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed:
                                            () => Navigator.pop(ctx, true),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                            );
                            if (confirm == true) {
                              await deleteUser(user['Username']!);
                            }
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
