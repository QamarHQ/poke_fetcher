import 'package:flutter/material.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokémon App")),
      body: const Center(child: Text("Welcome to PokéFetcher!")),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Next"),
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailScreen()),
          );
        },
      ),
    );
  }
}
