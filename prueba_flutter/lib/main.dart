import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();

  await Hive.openBox('session');
  await Hive.openBox('pokemons');

  final logged = Hive.box('session').get('logged', defaultValue: false);

  runApp(MyApp(isLogged: logged));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLogged ? AppPages.home : AppPages.login,
      getPages: AppPages.routes,
    );
  }
}
