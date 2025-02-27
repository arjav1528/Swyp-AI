// lib/screens/genre_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:swyp_ai/core/models/genre.dart';
import 'package:swyp_ai/widgets/navbar.dart';
import 'package:swyp_ai/widgets/gradient_button.dart';
import 'package:swyp_ai/widgets/genre_tile.dart';
import 'package:swyp_ai/constants/genre_constants.dart';
import '../constants/constants.dart';
import '../widgets/gradient_text.dart';
import 'home.dart';
import '../utils/logger.dart';

class GenreSelectionScreen extends StatefulWidget {
  const GenreSelectionScreen({super.key});

  @override
  _GenreSelectionScreenState createState() => _GenreSelectionScreenState();
}

class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  final List<Genre> selectedGenres = [];

  @override
  void initState() {
    super.initState();
    AppLogger.debug('GenreSelectionScreen initialized');
    _loadGenres();
  }

  Future<void> _loadGenres() async {
    try {
      AppLogger.info('Loading genres');
      // Your genre loading logic
      AppLogger.debug('Genres loaded successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load genres', e, stackTrace);
    }
  }

  void _handleGenreSelection(Genre genre) {
    AppLogger.debug('Genre selected: ${genre.name}');
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
        AppLogger.debug('Genre removed: ${genre.name}');
      } else {
        selectedGenres.add(genre);
        AppLogger.debug('Genre added: ${genre.name}');
      }
    });
  }

  void _handleContinue() {
    if (selectedGenres.isEmpty) {
      AppLogger.warning('Attempted to continue without selecting genres');
      // Show error to user
      return;
    }

    AppLogger.info(
      'Selected genres: ${selectedGenres.map((g) => g.name).join(", ")}',
    );
    AppLogger.logNavigation('GenreSelectionScreen', 'HomeScreen');
    // Navigation logic
  }

  @override
  void dispose() {
    AppLogger.debug('GenreSelectionScreen disposed');
    super.dispose();
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
          style: CustomTheme.theme.textTheme.bodyLarge?.copyWith(
            color: CustomTheme.disabledColor,
            fontSize: 18,
          ),
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
        children:
            genres
                .map(
                  (genre) => GenreTile(
                    genre: genre,
                    isSelected: selectedGenres.contains(genre),
                    onTap: () => _handleGenreSelection(genre),
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildContinueButton() {
    return GradientButton(
      onPressed: _handleContinue,
      child: const Text(
        'Continue',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
