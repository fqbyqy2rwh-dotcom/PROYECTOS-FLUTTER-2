import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Estados
  final isLoading = false.obs;
  final isLogged = false.obs;

  /// Hive box para sesion
  late Box sessionBox;

  @override
  void onInit() {
    super.onInit();
    sessionBox = Hive.box('session');
    _checkSession();
  }

  /// Verificar sesion guardada
  void _checkSession() {
    final logged = sessionBox.get('logged', defaultValue: false);
    isLogged.value = logged;

    if (logged) {
      Get.offAllNamed('/home');
    }
  }

  ///Validar email
  bool _isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }

  /// Registro de usario
  Future<void> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios');
      return;
    }

    if (!_isValidEmail(email)) {
      Get.snackbar('Error', 'Email inválido');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'La contraseña debe tener mínimo 6 caracteres');
      return;
    }

    try {
      isLoading.value = true;

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      sessionBox.put('logged', true);
      isLogged.value = true;

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Registro fallido', e.message ?? 'Error desconocido');
    } finally {
      isLoading.value = false;
    }
  }

  ///Login
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios');
      return;
    }

    if (!_isValidEmail(email)) {
      Get.snackbar('Error', 'Email inválido');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Contraseña inválida');
      return;
    }

    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      sessionBox.put('logged', true);
      isLogged.value = true;

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login fallido', e.message ?? 'Error desconocido');
    } finally {
      isLoading.value = false;
    }
  }

  ///logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await sessionBox.clear();

      isLogged.value = false;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'No se pudo cerrar sesión');
    }
  }

  ///usuario actual
  User? get currentUser => _auth.currentUser;
}
