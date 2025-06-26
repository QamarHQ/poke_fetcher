import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: PokeFetcherApp()));
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



