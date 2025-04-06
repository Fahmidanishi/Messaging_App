import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text("Help & Support"),
        backgroundColor: Colors.amber,
      ),      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Section
            _buildSectionTitle("Contact Us"),
            _buildContactTile(Icons.email, "Email", "support@example.com"),
            _buildContactTile(Icons.phone, "Phone", "+123 456 7890"),
            _buildContactTile(Icons.chat, "Live Chat", "Chat with us"),

            const SizedBox(height: 24),

            // FAQ Section
            _buildSectionTitle("FAQs"),
            _buildFAQItem("How to reset my password?", "Go to settings > Change Password and follow the instructions."),
            _buildFAQItem("How to contact support?", "You can email us, call us, or use the live chat feature."),
            _buildFAQItem("How do I delete my account?", "Please contact support to request account deletion."),

            const SizedBox(height: 24),

            // Feedback Section
            _buildSectionTitle("Submit Feedback"),
            _buildFeedbackForm(),

            const SizedBox(height: 24),
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

  // FAQ Expandable Item
  Widget _buildFAQItem(String question, String answer) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(answer),
          )
        ],
      ),
    );
  }

  // Feedback Form
  Widget _buildFeedbackForm() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your feedback...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // Add submit action
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Submit", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
