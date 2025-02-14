import 'package:flutter/material.dart';
import 'package:swyp_ai/widgets/card.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CardWidget(quote: "When life gives you lemon, squeeze it on someone's facer",)
      ),
    );
  }
}