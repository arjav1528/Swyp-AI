// lib/screens/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:swyp_ai/screens/genre_selection.dart';
import 'package:swyp_ai/screens/register_screen.dart';
import 'package:swyp_ai/widgets/gradient_text.dart';
import '../constants/constants.dart'; // Import CustomTheme
import '../utils/logger.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppLogger.debug('AuthScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.debug('AuthScreen disposed');
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    AppLogger.info('Login attempt started');
    try {
      final email = _emailController.text;
      final password = _passwordController.text;

      // Validate inputs
      if (email.isEmpty || password.isEmpty) {
        AppLogger.warning('Login attempted with empty credentials');
        // Show error to user
        return;
      }

      AppLogger.debug('Login credentials validated');

      // Mock API call logging
      AppLogger.logApi(
        '/auth/login',
        request: {'email': email, 'password': '***'},
      );

      // Navigate to next screen
      AppLogger.logNavigation('AuthScreen', 'GenreSelectionScreen');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GenreSelectionScreen()),
      );

      AppLogger.info('Login successful for user: $email');
    } catch (e, stackTrace) {
      AppLogger.error('Login failed', e, stackTrace);
      // Show error to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.theme.scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                GradientText(
                  text: "Welcome Back to Swyp",
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1f3d91), Color(0xFF4385f3)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  fontSize: 33,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue your personalized experience',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Email or Username',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  style: CustomTheme.theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter your email or username',
                    filled: true,
                    fillColor: const Color(0xFF111827),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Password',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: CustomTheme.theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: const Color(0xFF111827),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forgot password functionality
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: CustomTheme.accentColor),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade900, // Color of the line
                        thickness: 1, // Thickness of the line
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(
                          color: CustomTheme.disabledColor,
                        ), // Customize as needed
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.grey.shade900, thickness: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Add Google sign in functionality
                        },
                        icon: const Icon(
                          Icons.g_mobiledata_sharp,
                          color: CustomTheme.textColor,
                        ),
                        label: const Text(
                          'Google',
                          style: TextStyle(
                            color: CustomTheme.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(color: Colors.grey.shade900),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Add Apple sign in functionality
                        },
                        icon: const Icon(
                          Icons.apple,
                          color: CustomTheme.textColor,
                        ),
                        label: const Text(
                          'Apple',
                          style: TextStyle(
                            color: CustomTheme.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(color: Colors.grey.shade900),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: CustomTheme.disabledColor,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            color: CustomTheme.accentColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
