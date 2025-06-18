import 'dart:convert';
import 'package:http/http.dart' as http;

class PokeService {
  static Future<Map<String, dynamic>> getPokemonData(String name) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }
}
