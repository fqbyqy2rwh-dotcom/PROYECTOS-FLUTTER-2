# prueba_flutter

prueba de Jeferson Ricardo Salazar

## Prueba Tecnica Flutter – Autenticación, API y Persistencia Local
Descripción

Registro de usuario con correo y contraseña

Inicio de sesion

Cierre de sesión

Validación de formularios:

Email válido

Contraseña segura (mínimo 6 caracteres, 1 mayúscula, 1 número y 1 símbolo)

Persistencia de sesión:

Si el usuario ya inició sesión, no se vuelve a pedir login

## Home

Consumo de datos desde una API pública (PokéAPI)

Listado de información en pantalla principal

Cache local automático con Hive

Modo offline:

Si no hay conexión, se muestran los datos almacenados

## Detalle

Navegación a pantalla de detalle al seleccionar un elemento

Visualización de información completa usando argumentos con GetX

## Arquitectura del Proyecto
          lib/
          │
          ├── main.dart
          ├── routes/
          │   └── app_pages.dart
          │
          ├── data/
          │   ├── models/
          │   │   └── pokemon_model.dart
          │   ├── services/
          │   │   ├── api_service.dart
          │   │   └── auth_service.dart
          │   └── local/
          │       └── hive_service.dart
          │
          ├── controllers/
          │   ├── auth_controller.dart
          │   ├── home_controller.dart
          │   └── detail_controller.dart
          │
          ├── views/
          │   ├── login_page.dart
          │   ├── register_page.dart
          │   ├── home_page.dart
          │   └── detail_page.dart
          │
          └── bindings/
              └── initial_binding.dart

## Decisiones clave

GetX se utiliza para:

Manejo de estado

Navegación

Inyección de dependencias

Hive se usa como cache local para:

Persistir sesión

Guardar datos de la API y permitir modo offline

La lógica de negocio se mantiene fuera de la UI (controllers)

## Dependencias Principales
    get: ^4.6.6
    hive: ^2.2.3
    hive_flutter: ^1.1.0
    firebase_core: ^2.x.x
    firebase_auth: ^4.x.x
    http: ^1.x.x

## Requisitos

Flutter 3.x o superior

Android SDK (minSdkVersion 21)

Proyecto configurado en Firebase

Authentication → Email/Password habilitado

google-services.json agregado correctamente

## Cómo ejecutar el proyecto

Clonar el repositorio

Instalar dependencias:

flutter pub get


Configurar Firebase (Android)

## Ejecutar la aplicación:

flutter run

## Generar APK
flutter build apk --release

