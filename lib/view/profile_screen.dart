import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName = "John Doe";
  final String userEmail = "john.doe@example.com";
  final int userPoints = 1500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                child:  Icon(Icons.person, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(
                "Name: $userName",
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Add functionality for editing the name
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Email: $userEmail",
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Add functionality for editing the email
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Points: $userPoints",
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Add functionality for viewing points details
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Settings",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Add functionality for Settings 1
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "Logout",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              onTap: () {
                // Add functionality for logging out
              },
            ),
          ],
        ),
      ),
    );
  }
}

