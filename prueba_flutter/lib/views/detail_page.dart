import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final DetailController controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    final pokemon = controller.pokemon;

    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name.toUpperCase())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pokemon.name.toUpperCase(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('URL:'),
            Text(pokemon.url, style: const TextStyle(color: Colors.blue)),
            const SizedBox(height: 24),
            const Text(
              'Detalle obtenido desde navegación GetX',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
