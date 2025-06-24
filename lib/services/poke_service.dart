import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';
import '../models/pokemon_list_item.dart';

class PokeService {
  static Future<List<PokemonListItem>> getPokemonList(int count) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$count&offset=0');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((item) => PokemonListItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Pokémon list.');
    }
  }

  static Future<PokemonModel> getPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PokemonModel.fromJSON(jsonData);
    } else {
      throw Exception('Failed to load Pokémon details.');
    }
  }

  static Future<PokemonModel> getPokemonData(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PokemonModel.fromJSON(jsonData);
    } else {
      throw Exception('That Pokémon doesn’t exist.');
    }
  }
}


