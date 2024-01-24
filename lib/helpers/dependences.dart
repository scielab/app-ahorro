
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  await Get.putAsync(() async => await SharedPreferences.getInstance(),permanent: true);

  Get.put(AuthController());
  //Get.lazyPut(() => PaymentsController());   

}