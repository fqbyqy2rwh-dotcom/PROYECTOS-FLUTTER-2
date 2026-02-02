import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authController.logout,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pokemons.isEmpty) {
          return const Center(child: Text('No hay datos'));
        }

        return ListView.builder(
          itemCount: controller.pokemons.length,
          itemBuilder: (_, index) {
            final pokemon = controller.pokemons[index];
            return ListTile(
              title: Text(pokemon.name.toUpperCase()),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.toNamed('/detail', arguments: pokemon);
              },
            );
          },
        );
      }),
    );
  }
}
