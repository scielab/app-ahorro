
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  await Get.putAsync(() async => await SharedPreferences.getInstance());

  Get.putAsync(() async => AuthController());
  //Get.lazyPut(() => PaymentsController());   

}