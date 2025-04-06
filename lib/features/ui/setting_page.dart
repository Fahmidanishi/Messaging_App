import 'package:flutter/material.dart';

import '../../common/custom_navigator.dart';
import '../auth/login_page.dart';
import 'about_page.dart';
import 'edit_profile.dart';
import 'help_support_page.dart';
import 'language_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Settings",
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Profile Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade300, Colors.amber.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Profile Picture
                  const CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 70, color: Colors.grey),
                  ),

                  const SizedBox(width: 16),

                  // User Info & Button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Nishi",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "nishi@example.com",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 12),

                        // Edit Profile Button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              customNavigator(context, const EditProfile());
                            },
                            icon: const Icon(Icons.edit,
                                size: 18, color: Colors.black),
                            label: const Text("Edit Profile",
                                style: TextStyle(color: Colors.black)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Settings List
            _buildSettingsOption(Icons.language, "Language", () {
              customNavigator(context,  const LanguagePage());

            }),
            _buildSettingsOption(Icons.help_outline, "Help & Support", () {
              customNavigator(context,  const HelpSupportPage());

            }),
            _buildSettingsOption(Icons.info_outline, "About", () {
              customNavigator(context,  const AboutPage());

            }),

            const Spacer(),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                customNavigator(context,  const LoginPage());

              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label:
                  const Text("Logout", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(double.infinity, 48),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Reusable Widget for Settings Options
  Widget _buildSettingsOption(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.amber.shade700),
          title: Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(color: Colors.grey.shade300),
      ],
    );
  }
}
