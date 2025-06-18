import 'package:flutter/material.dart';
import '../services/poke_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? imageUrl;
  String name = '';

  @override
  void initState() {
    super.initState();
    fetchPikachu();
  }

  void fetchPikachu() async {
    final data = await PokeService.getPokemonData('pikachu');
    setState(() {
      name = data['name'];
      imageUrl = data['sprites']['front_default'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pikachu Details")),
      body: Center(
        child: imageUrl == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(imageUrl!),
                  const SizedBox(height: 20),
                  Text(name.toUpperCase(), style: const TextStyle(fontSize: 24)),
                ],
              ),
      ),
    );
  }
}
