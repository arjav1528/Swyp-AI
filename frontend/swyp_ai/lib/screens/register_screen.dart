import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:swyp_ai/widgets/gradient_text.dart';
import '../utils/logger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'Male';

  @override
  void initState() {
    super.initState();
    AppLogger.debug('RegisterScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.debug('RegisterScreen disposed');
    _usernameController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _handleRegistration() {
    AppLogger.info('Registration attempt started');
    try {
      // Get form values
      final email = _usernameController.text;
      final password = _passwordController.text;
      final username = _usernameController.text;

      // Validate inputs
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        AppLogger.warning('Registration attempted with incomplete data');
        // Show error to user
        return;
      }

      AppLogger.debug('Registration data validated');

      // Mock API call
      AppLogger.logApi(
        '/auth/register',
        request: {'email': email, 'username': username, 'password': '***'},
      );

      AppLogger.logNavigation('RegisterScreen', 'GenreSelectionScreen');
      // Navigation logic

      AppLogger.info('Registration successful for user: $email');
    } catch (e, stackTrace) {
      AppLogger.error('Registration failed', e, stackTrace);
      // Show error to user
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientText(
                      text: "Create Account",
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1f3d91), Color(0xFF4385f3)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      fontSize: 33,
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: CustomTheme.textColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to start your journey',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Username',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usernameController,
                  style: CustomTheme.theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    filled: true,
                    fillColor: const Color(0xFF111827),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Password',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  style: CustomTheme.theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    fillColor: const Color(0xFF111827),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Age',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _ageController,
                  style: CustomTheme.theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Enter your age',
                    filled: true,
                    fillColor: const Color(0xFF111827),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 13) {
                      return 'You must be at least 13 years old';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Gender',
                  style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                    color: CustomTheme.disabledColor,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  style: CustomTheme.theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF111827),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  value: _selectedGender,
                  dropdownColor: const Color(0xFF111827),
                  items:
                      ['Male', 'Female', 'Other']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedGender = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _handleRegistration,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: CustomTheme.disabledColor,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign in',
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
