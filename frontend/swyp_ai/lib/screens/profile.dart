// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:swyp_ai/widgets/navbar.dart';
import 'package:swyp_ai/constants/constants.dart'; // Import your constants file
import '../utils/logger.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileName = "Profile Photo";

  @override
  void initState() {
    super.initState();
    AppLogger.debug('ProfileScreen initialized');
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      AppLogger.info('Loading user profile');
      AppLogger.logApi('/user/profile', request: 'GET');
      // Profile loading logic
      AppLogger.debug('Profile loaded successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load profile', e, stackTrace);
    }
  }

  void _handleProfileUpdate() {
    AppLogger.info('Profile update started');
    try {
      // Update logic
      AppLogger.logApi(
        '/user/profile/update',
        request: {'updated_fields': 'profile_data'},
      );
      AppLogger.info('Profile updated successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update profile', e, stackTrace);
    }
  }

  void _handleLogout() {
    AppLogger.info('User logout initiated');
    try {
      // Logout logic
      AppLogger.logNavigation('ProfileScreen', 'AuthScreen');
      AppLogger.info('Logout successful');
    } catch (e, stackTrace) {
      AppLogger.error('Logout failed', e, stackTrace);
    }
  }

  @override
  void dispose() {
    AppLogger.debug('ProfileScreen disposed');
    super.dispose();
  }

  void _editProfile() {
    showDialog(
      context: context,
      builder:
          (context) => EditProfileDialog(
            initialName: profileName,
            onSave: (newName) {
              setState(() {
                profileName = newName;
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              ProfileHeader(profileName: profileName, onEdit: _editProfile),
              const SizedBox(height: 16),
              const BioButton(),
              const SizedBox(height: 40),
              const SavedPostsSection(),
            ],
          ),
        ),
        bottomNavigationBar: const Navbar(),
      ),
    );
  }
}

//  Reusable Widgets

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profileName,
    required this.onEdit,
  });

  final String profileName;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                profileName,
                textAlign: TextAlign.center,
                style: CustomTheme.theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                ), // Using theme
              ),
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: CustomTheme.accentColor, // Using theme color
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class BioButton extends StatelessWidget {
  const BioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: const Text("Bio"));
  }
}

class SavedPostsSection extends StatelessWidget {
  const SavedPostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Saved Posts",
              style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
                color: CustomTheme.accentColor,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Divider(
          color: CustomTheme.accentColor,
          thickness: 2,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 16),
        SavedPostsGrid(),
      ],
    );
  }
}

class SavedPostsGrid extends StatelessWidget {
  const SavedPostsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: 4, // Show 4 items as in the image
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              "Why did the scarecrow win an award? Because he was outstanding in his field!",
              textAlign: TextAlign.center,
              style:
                  CustomTheme
                      .theme
                      .textTheme
                      .bodyMedium, // Applying text style from the theme
            ),
          ),
        );
      },
    );
  }
}

class EditProfileDialog extends StatelessWidget {
  const EditProfileDialog({
    super.key,
    required this.initialName,
    required this.onSave,
  });

  final String initialName;
  final Function(String) onSave;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: initialName);
    return AlertDialog(
      backgroundColor: CustomTheme.theme.dialogBackgroundColor,
      title: const Text("Edit Profile"),
      content: TextField(
        controller: nameController,
        style: CustomTheme.theme.textTheme.bodyLarge,
        decoration: const InputDecoration(hintText: "Enter your name"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            onSave(nameController.text);
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
