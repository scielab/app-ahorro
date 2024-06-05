
import 'package:app/controllers/activity/activity_controller.dart';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/auth/email_verification_controller.dart';
import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/controllers/budget/budget_item_controller.dart';
import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/controllers/history/history_controller.dart';
import 'package:app/controllers/history/history_lecture_controller.dart';
import 'package:app/controllers/home/home_controller.dart';
import 'package:app/controllers/progress/progress_controller.dart';
import 'package:get/get.dart';


class BindingInit implements Bindings {
  @override
  void dependencies() async {
    Get.put(AuthController());

    Get.lazyPut(() => BudgetItemController(), fenix: true);
    Get.lazyPut(() => GuildController(), fenix: true);
    Get.lazyPut(() => ActivityControlller(), fenix: true);
  
    Get.lazyPut(() => BudgetController(), fenix: true);
    Get.lazyPut(() => ProgressController(), fenix: true);
    Get.lazyPut(() => GuildController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HistoryController(),fenix: true);
    Get.lazyPut(() => HistoryLectureController(), fenix: true);
    Get.lazyPut(() => EmailVerificationController(), fenix: true);
  }
}