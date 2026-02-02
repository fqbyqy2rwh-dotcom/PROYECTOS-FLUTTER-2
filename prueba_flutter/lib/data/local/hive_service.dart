import 'package:hive/hive.dart';
import '../models/pokemon_model.dart';

class HiveService {
  static const boxName = 'pokemons';

  Box get _box => Hive.box(boxName);

  bool hasData() => _box.isNotEmpty;

  List<PokemonModel> getPokemons() {
    return _box.values
        .map((e) => PokemonModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void savePokemons(List<PokemonModel> pokemons) {
    if (_box.isNotEmpty) return; // evita duplicados

    for (var p in pokemons) {
      _box.add(p.toJson());
    }
  }
}
