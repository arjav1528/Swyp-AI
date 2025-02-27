// constants/genre_constants.dart
import 'package:flutter/material.dart';
import 'package:swyp_ai/core/models/genre.dart';

const List<Genre> genres = [
  Genre(name: 'humor', label: 'Humor', icon: Icons.sentiment_satisfied),
  Genre(name: 'thriller', label: 'Thriller', icon: Icons.visibility),
  Genre(name: 'horror', label: 'Horror', icon: Icons.sentiment_dissatisfied),
  Genre(name: 'wholesome', label: 'Wholesome', icon: Icons.favorite),
  Genre(name: 'love', label: 'Love', icon: Icons.favorite_border),
  Genre(name: 'reflections', label: 'Reflections', icon: Icons.question_mark),
  Genre(name: 'roast_me', label: 'Roast Me', icon: Icons.emoji_emotions_outlined),
  Genre(name: 'mixed_bag', label: 'Mixed Bag', icon: Icons.category_outlined),
];
