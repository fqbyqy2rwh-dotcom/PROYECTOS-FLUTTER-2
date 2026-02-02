import 'package:get/get.dart';
import '../data/models/pokemon_model.dart';
import '../data/services/api_service.dart';
import '../data/local/hive_service.dart';

class HomeController extends GetxController {
  final ApiService _apiService = ApiService();
  final HiveService _hiveService = HiveService();

  final isLoading = true.obs;
  final pokemons = <PokemonModel>[].obs;
  final error = ''.obs;

  @override
  void onInit() {
    fetchPokemons();
    super.onInit();
  }

  Future<void> fetchPokemons() async {
    try {
      // Si hay datos locales → usar Hive
      if (_hiveService.hasData()) {
        pokemons.value = _hiveService.getPokemons();
      } else {
        final data = await _apiService.getPokemons();
        pokemons.value = data;
        _hiveService.savePokemons(data);
      }
    } catch (e) {
      error.value = 'Sin conexión. Mostrando datos locales.';
      pokemons.value = _hiveService.getPokemons();
    } finally {
      isLoading.value = false;
    }
  }
}
