import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../auth/login_page.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final oldPassword = _oldPassController.text.trim();
      final newPassword = _newPassController.text.trim();

      // Step 1: Sign in with email and old password
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      // Step 2: Update to new password
      await userCredential.user?.updatePassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );

      // Optional: Sign out or navigate
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Error occurred';
      if (e.code == 'user-not-found') message = 'No user found';
      else if (e.code == 'wrong-password') message = 'Old password is incorrect';
      else if (e.code == 'weak-password') message = 'Password too weak';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _oldPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Reset Your Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: EmailValidator(errorText: 'Enter valid email'),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _oldPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Old Password'),
                  validator: RequiredValidator(errorText: 'Enter old password'),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _newPassController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'New Password'),
                  validator: MinLengthValidator(6, errorText: 'Minimum 6 characters required'),
                ),
                const SizedBox(height: 30),

                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
