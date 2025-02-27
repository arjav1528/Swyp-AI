import 'package:flutter/material.dart';
import 'package:swyp_ai/widgets/card.dart';
import '../utils/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AppLogger.debug('HomeScreen initialized');
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    try {
      AppLogger.info('Loading home screen data');
      AppLogger.logApi('/home/feed', request: 'GET');
      // Data loading logic
      AppLogger.debug('Home data loaded successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load home data', e, stackTrace);
    }
  }

  void _handleRefresh() {
    AppLogger.info('Refreshing home screen');
    _loadHomeData();
  }

  void _handleItemSelection(String itemId) {
    AppLogger.debug('Item selected: $itemId');
    try {
      // Item selection logic
      AppLogger.logApi('/items/$itemId', request: 'GET');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to process item selection', e, stackTrace);
    }
  }

  @override
  void dispose() {
    AppLogger.debug('HomeScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CardWidget(quote: "When life gives you lemon, squeeze it on someone's facer",)
      ),
    );
  }
}