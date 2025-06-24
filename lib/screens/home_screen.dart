import 'package:flutter/material.dart';
import 'pokemon_list_screen.dart';
import 'search_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokémon App")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PokemonListScreen()),
              ),
              child: const Text("List Pokémon"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchDetailScreen()),
              ),
              child: const Text("Search Pokémon by Name"),
            )
          ],
        ),
      ),
    );
  }
}
