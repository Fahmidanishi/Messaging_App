import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/features/ui/main_bottom_nav.dart';
import '../../common/constrants.dart';
import '../../common/custom_navigator.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _aboutTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: BoxDecoration(gradient: background),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create Account!',
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 44),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _nameTEController,
                      decoration: const InputDecoration(hintText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _aboutTEController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(hintText: 'About yourself'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 44),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                          onPressed: nextPage, child: const Text('Sign Up')),
                    const SizedBox(height: 44),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        text: 'Have an account? ',
                        children: [
                          TextSpan(
                            style: const TextStyle(color: Colors.blue),
                            text: 'Login',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                customNavigator(context, LoginPage());
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void nextPage() async {
    if (!_globalKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'name': _nameTEController.text.trim(),
        'email': _emailTEController.text.trim(),
        'about': _aboutTEController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      customNavigator(context, const MainBottomNav());
    } on FirebaseAuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError("An error occurred. Please try again.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showError(String? message) {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? "An error occurred")),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _aboutTEController.dispose();
    super.dispose();
  }
}
