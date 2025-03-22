
import 'package:app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseApiNotification {
  // Crear una instancia de Firebase
  final _firebaseMessaging = FirebaseMessaging.instance;

  // funcion a inicializar las notificaciones

  Future<void> initNotification() async {
    // solicitar permisos al usuario
    await _firebaseMessaging.requestPermission();
    // traer el FCM token para este servicio
    final fcmToken = await _firebaseMessaging.getToken();
    // mostrar el token
    print("token: $fcmToken");
  }

  // funcion a tomar mensajes
  void handleMessage(RemoteMessage? message) {
    if(message == null) return;
    navigatorKey.currentState?.pushNamed('/notification_screen',arguments: message);
    // Redirigir a una ruta definida
  }
  // función para inicializar la configuración de primer plano y fondo
  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

}