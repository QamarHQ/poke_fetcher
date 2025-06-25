import 'package:flutter/material.dart';
import '../models/pokemon_list_item.dart';
import '../models/pokemon_model.dart';
import '../services/poke_service.dart';
import 'detail_screen.dart';

class FilteredListScreen extends StatelessWidget {
  final List<PokemonListItem> filteredList;
  final String title;

  const FilteredListScreen({
    super.key,
    required this.filteredList,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filtered: $title Pokémon")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            final pokemon = filteredList[index];
            return ListTile(
              title: Text(pokemon.name.toUpperCase()),
              onTap: () async {
                try {
                  final details = await PokeService.getPokemonDetails(pokemon.url);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(pokemon: details),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to load details")),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
