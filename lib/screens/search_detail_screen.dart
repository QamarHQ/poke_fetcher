import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';
import '../services/poke_service.dart';

class SearchDetailScreen extends StatefulWidget {
  const SearchDetailScreen({super.key});

  @override
  State<SearchDetailScreen> createState() => _SearchDetailScreenState();
}

class _SearchDetailScreenState extends State<SearchDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  PokemonModel? _pokemon;
  String? _error;

  @override
  void initState() {
    super.initState();
    _searchPokemon('pikachu');
    _controller.text = 'pikachu';
  }

  void _searchPokemon([String? name]) async {
    final input = name ?? _controller.text.trim().toLowerCase();
    if (input.isEmpty) return;

    setState(() {
      _pokemon = null;
      _error = null;
    });

    try {
      final result = await PokeService.getPokemonData(input);
      setState(() => _pokemon = result);
    } catch (e) {
      setState(() => _error = e.toString().replaceAll('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Pokémon")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Pokémon name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchPokemon,
              child: const Text("Search"),
            ),
            const SizedBox(height: 20),
            if (_pokemon != null)
              Column(
                children: [
                  Image.network(_pokemon!.imageUrl, width: 200, height: 200),
                  const SizedBox(height: 10),
                  Text(
                    _pokemon!.name.toUpperCase(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              )
            else if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
