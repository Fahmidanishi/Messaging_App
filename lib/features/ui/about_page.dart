import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("About"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber.shade100,
              ),
              child: const Icon(CupertinoIcons.chat_bubble_2_fill, size: 80, color: Colors.amber),
            ),

            const SizedBox(height: 12),

            // App Name & Version
            const Text(
              "Chat App",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),

            const SizedBox(height: 20),

            // About the App
            _buildSectionTitle("About This App"),
            const Text(
              "Chat App is a modern messaging app that allows you to chat with friends, "
                  "join groups, and share media seamlessly. Built with Flutter for a smooth and fast experience.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Developers / Contributors
            _buildSectionTitle("Developed By"),
            _buildDeveloperCard("Nishi", "Flutter Developer", Icons.code),
            _buildDeveloperCard("Nishi's Team", "Software Development Team", Icons.business),

            const SizedBox(height: 20),

            // Contact Information
            _buildSectionTitle("Connect With Us"),
            _buildContactTile(Icons.email, "Email", "support@chatapp.com"),
            _buildContactTile(Icons.language, "Website", "www.chatapp.com"),
            _buildContactTile(Icons.facebook, "Facebook", "facebook.com/chatapp"),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Developer Card Widget
  Widget _buildDeveloperCard(String name, String role, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(role),
      ),
    );
  }

  // Contact Tile Widget
  Widget _buildContactTile(IconData icon, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {}, // Add action here
      ),
    );
  }
}
