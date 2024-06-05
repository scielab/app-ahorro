import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/controllers/activity/activity_controller.dart';
import 'package:app/pages/splash/splash_screen_select.dart';

class HomeController extends GetxController {
  late ActivityControlller _activityController;

  @override
  void onInit() {
    super.onInit();
    _activityController = Get.find<ActivityControlller>();
  }

  void verificateDificulty() async {
    bool response = await _activityController.isDificultySelected();
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    if(!response) {
      sharedPreference.remove('dificulty');
      Get.to(() => const SplashSreenSelect());
    }
  }

}