import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _nameController.text = userDoc['name'] ?? '';
        _aboutController.text = userDoc['about'] ?? '';
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_user != null) {
          // Update display name
          await _user!.updateDisplayName(_nameController.text);

          // Update Firestore user data
          await _firestore.collection('users').doc(_user!.uid).update({
            'name': _nameController.text,
            'about': _aboutController.text,
          });

          // Optional password change
          if (_passwordController.text.isNotEmpty) {
            await _user!.updatePassword(_passwordController.text);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully!")),
          );

          Navigator.pop(context, true); // Go back to settings page
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  // Function to delete account
  Future<void> _deleteAccount() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('This will permanently delete your account and all data associated with it.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  if (_user != null) {
                    // Delete the user document from Firestore
                    await _firestore.collection('users').doc(_user!.uid).delete();

                    // Delete the Firebase Authentication user
                    await _user!.delete();

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Account deleted successfully")),
                    );

                    // Navigate to the login page after deletion
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String email = _auth.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile",
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person,
                          size: 70, color: Colors.grey),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.email, color: Colors.amber),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                email,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              _buildTextFormField("Full Name", _nameController),
              const SizedBox(height: 16),

              _buildTextFormField("About", _aboutController, maxLines: 3),
              const SizedBox(height: 16),

              // // Email (read-only)
              // TextFormField(
              //   initialValue: email,
              //   readOnly: true,
              //   decoration: const InputDecoration(
              //     labelText: "Email",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.amber.shade700,
                  ),
                  child: const Text("Save Changes",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 24),

              // Delete Account Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _deleteAccount,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.red.shade700,
                  ),
                  child: const Text("Delete Account",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        bool obscureText = false,
        int maxLines = 1,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (label.contains("Password")) return null;
        if (value == null || value.trim().isEmpty) {
          return "$label can't be empty";
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
