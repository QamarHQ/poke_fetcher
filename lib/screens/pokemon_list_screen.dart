import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/poke_service.dart';
import '../models/pokemon_list_item.dart';
import '../models/pokemon_model.dart';
import 'detail_screen.dart';

// Providers
final pokemonListProvider = StateNotifierProvider<PokemonListNotifier, List<PokemonListItem>>(
  (ref) => PokemonListNotifier(),
);

final filteredListProvider = StateProvider<List<PokemonListItem>>((ref) => []);
final isFilteredProvider = StateProvider<bool>((ref) => false);

// Notifier to fetch Pokémon list
class PokemonListNotifier extends StateNotifier<List<PokemonListItem>> {
  PokemonListNotifier() : super([]);

  Future<void> fetchPokemon(int count, WidgetRef ref) async {
    try {
      final list = await PokeService.getPokemonList(count);
      state = list;
      ref.read(filteredListProvider.notifier).state = List.from(list);
      ref.read(isFilteredProvider.notifier).state = false;
    } catch (_) {
      state = [];
      ref.read(filteredListProvider.notifier).state = [];
      ref.read(isFilteredProvider.notifier).state = false;
    }
  }
}

// Main List Screen
class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  void _filterOdd() {
    final list = ref.read(pokemonListProvider);
    ref.read(filteredListProvider.notifier).state = list
        .asMap()
        .entries
        .where((entry) => entry.key.isOdd)
        .map((entry) => entry.value)
        .toList();
    ref.read(isFilteredProvider.notifier).state = true;
  }

  void _filterEven() {
    final list = ref.read(pokemonListProvider);
    ref.read(filteredListProvider.notifier).state = list
        .asMap()
        .entries
        .where((entry) => entry.key.isEven)
        .map((entry) => entry.value)
        .toList();
    ref.read(isFilteredProvider.notifier).state = true;
  }

  void _resetList() {
    ref.read(filteredListProvider.notifier).state = List.from(ref.read(pokemonListProvider));
    ref.read(isFilteredProvider.notifier).state = false;
  }

  Future<void> _fetch() async {
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

    setState(() => _error = null);
    await ref.read(pokemonListProvider.notifier).fetchPokemon(number, ref);
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(filteredListProvider);
    final isFiltered = ref.watch(isFilteredProvider);

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
            ElevatedButton(onPressed: _fetch, child: const Text("Search")),
            const SizedBox(height: 10),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            if (list.isNotEmpty && !isFiltered)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(onPressed: _filterOdd, child: const Text("Odd")),
                  OutlinedButton(onPressed: _filterEven, child: const Text("Even")),
                ],
              ),
            if (isFiltered)
              TextButton(onPressed: _resetList, child: const Text("Back to Full List")),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final pokemon = list[index];
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
          ],
        ),
      ),
    );
  }
}





