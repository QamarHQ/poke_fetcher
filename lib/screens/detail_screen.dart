import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class DetailScreen extends StatelessWidget {
  final PokemonModel pokemon;

  const DetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name.toUpperCase())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, width: 150, height: 150),
            const SizedBox(height: 16),
            Text(pokemon.name.toUpperCase(),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            _buildInfoCard("ID", pokemon.id.toString()),
            _buildInfoCard("Height", "${pokemon.height / 10} m"),
            _buildInfoCard("Weight", "${pokemon.weight / 10} kg"),
            _buildInfoCard("Base Experience", pokemon.baseExperience.toString()),
            _buildInfoCard("Types", pokemon.types.join(', ')),

            const SizedBox(height: 20),
            const Text("Base Stats",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...pokemon.stats.entries
                .map((entry) => _buildStatBar(entry.key, entry.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.info_outline),
        title: Text(label),
        trailing: Text(value),
      ),
    );
  }

  Widget _buildStatBar(String statName, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(statName.toUpperCase()),
          LinearProgressIndicator(
            value: value / 100,
            minHeight: 10,
            color: Colors.blue,
            backgroundColor: Colors.grey[300],
          ),
          Text('$value', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

