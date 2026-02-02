import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

class ApiService {
  static const _url = 'https://pokeapi.co/api/v2/pokemon?limit=20';

  Future<List<PokemonModel>> getPokemons() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((e) => PokemonModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Error al consumir API');
    }
  }
}
