import 'package:get/get.dart';
import '../data/models/pokemon_model.dart';

class DetailController extends GetxController {
  late PokemonModel pokemon;

  @override
  void onInit() {
    super.onInit();
    pokemon = Get.arguments as PokemonModel;
  }
}
