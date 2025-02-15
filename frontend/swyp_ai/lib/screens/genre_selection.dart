// lib/screens/genre_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:swyp_ai/widgets/navbar.dart';
import 'package:swyp_ai/widgets/gradient_button.dart';
import 'package:swyp_ai/widgets/genre_tile.dart';
import 'package:swyp_ai/constants/genre_constants.dart';
import '../constants/constants.dart';
import '../widgets/gradient_text.dart';
import 'home.dart';

class GenreSelectionScreen extends StatefulWidget {
  @override
  _GenreSelectionScreenState createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final Set<String> _selectedGenres = {};

  void _handleGenreSelection(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomTheme.theme.scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 10),
              _buildGenreGrid(),
              const SizedBox(height: 10),
              _buildContinueButton(),
            ],
          ),
        ),
        bottomNavigationBar: const Navbar(),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          text: "Choose Your Genre",
          gradient: LinearGradient(
            colors: [Color(0xFF1f3d91), Color(0xFF4385f3)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          fontSize: 33,
        ),
        const SizedBox(height: 8),
        Text(
          'Select what interests you',
          style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(color: CustomTheme.disabledColor, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildGenreGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: genres
            .map((genre) => GenreTile(
          genre: genre,
          isSelected: _selectedGenres.contains(genre.label),
          onTap: () => _handleGenreSelection(genre.label),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildContinueButton() {
    return GradientButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
      child: const Text(
        'Continue',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
