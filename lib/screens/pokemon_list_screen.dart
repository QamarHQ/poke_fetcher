import 'package:flutter/material.dart';
import '../services/poke_service.dart';
import '../models/pokemon_list_item.dart';
import '../models/pokemon_model.dart';
import 'detail_screen.dart';
import 'filtered_list_screen.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final TextEditingController _controller = TextEditingController();
  List<PokemonListItem> _pokemonList = [];
  String? _error;

  Future<void> _fetchPokemonList() async {
    final input = _controller.text.trim();

    if (input.isEmpty || int.tryParse(input) == null) {
      setState(() => _error = "Please enter a valid number.");
      return;
    }

    final number = int.parse(input);
    if (number <= 0 || number > 100) {
      setState(() => _error = "Number must be between 1 and 100.");
      return;
    }

    setState(() {
      _error = null;
      _pokemonList = [];
    });

    try {
      final list = await PokeService.getPokemonList(number);
      setState(() {
        _pokemonList = list;
      });
    } catch (e) {
      setState(() => _error = "Failed to fetch data.");
    }
  }

  void _navigateToFilteredList(bool showOdd) {
    final filtered = _pokemonList
        .asMap()
        .entries
        .where((entry) => showOdd ? entry.key.isOdd : entry.key.isEven)
        .map((entry) => entry.value)
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilteredListScreen(
          filteredList: filtered,
          title: showOdd ? "Odd" : "Even",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokémon List")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter number of Pokémon (1–100)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchPokemonList,
              child: const Text("Search"),
            ),
            const SizedBox(height: 10),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _pokemonList.length,
                itemBuilder: (context, index) {
                  final pokemon = _pokemonList[index];
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
            const SizedBox(height: 10),
            if (_pokemonList.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => _navigateToFilteredList(true),
                    child: const Text("Odd"),
                  ),
                  OutlinedButton(
                    onPressed: () => _navigateToFilteredList(false),
                    child: const Text("Even"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}




