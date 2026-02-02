import 'package:get/get.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';
import '../views/home_page.dart';
import '../views/detail_page.dart';
import '../bindings/initial_binding.dart';

class AppPages {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const detail = '/detail';

  static final routes = [
    GetPage(name: login, page: () => LoginPage(), binding: InitialBinding()),
    GetPage(name: register, page: () => RegisterPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: detail, page: () => DetailPage()),
  ];
}
