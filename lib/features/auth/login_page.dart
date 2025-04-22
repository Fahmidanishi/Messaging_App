import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/features/auth/signup_page.dart';
import '../../auth_service/firebase_auth_service.dart';
import '../../common/constrants.dart';
import '../../common/custom_navigator.dart';
import '../ui/forgot_pass_page.dart';
import '../ui/main_bottom_nav.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.sizeOf(context).height*1,
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
                                'Welcome Back!',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 44),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailTEController,
                                decoration:
                                const InputDecoration(hintText: 'Email'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 44),
                              TextFormField(
                                controller: _passwordTEController,
                                obscureText: true,
                                decoration:
                                const InputDecoration(hintText: 'password'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => customNavigator(
                                      context, const ForgotPassPage()),
                                  child: const Text('Reset Password.',
                                      style: TextStyle(color: Colors.amber)),
                                ),
                              ),
                              const SizedBox(height: 44),
                              ElevatedButton(
                                  onPressed: _onLogin,
                                  child: Text(_isLoading ? "loading..." : 'Login')),
                              const SizedBox(height: 44),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  text: 'Register?   ',
                                  children: [
                                    TextSpan(
                                      style: const TextStyle(color: Colors.blue),
                                      text: 'Sign Up',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          customNavigator(
                                              context, const SignUpPage());
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))))),
        ));
  }

  Future<void> _onLogin() async {
    if (!_globalKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      // Attempt login with email and password
      final loginResult = await AuthServices.onLogin(
        _emailTEController.text.trim(),
        _passwordTEController.text.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Check if the login was successful
      if (loginResult != null) {
        // If login is successful, navigate to HomePage
        if (mounted) {
          customNavigator(context, const MainBottomNav());
        }
      } else {
        throw Exception('Account does not exist or incorrect credentials');
      }
    } catch (e) {
      // If login fails, show an error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
