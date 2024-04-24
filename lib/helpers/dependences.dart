
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/controllers/budget/budget_item_controller.dart';
import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/controllers/progress/progress_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  await Get.putAsync(() async => await SharedPreferences.getInstance());

  Get.putAsync(() async => AuthController());
  //Get.lazyPut(() => PaymentsController());   
  //Get.put(BudgetController());
  Get.putAsync(() async => BudgetItemController());
  //Get.putAsync(() async => ProgressController());
  Get.putAsync(() async => GuildController());
}