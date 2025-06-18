import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PokeFetcherApp());
}

class PokeFetcherApp extends StatelessWidget {
  const PokeFetcherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokéFetcher',
      theme: ThemeData(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

