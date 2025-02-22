
import 'package:app/controllers/activity/activity_controller.dart';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/auth/email_verification_controller.dart';
import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/controllers/budget/budget_item_controller.dart';
import 'package:app/controllers/financial_accounts/financial_account_controller.dart';
import 'package:app/controllers/goals/goals_controller.dart';
import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/controllers/history/history_atributes_profile.dart';
import 'package:app/controllers/history/history_controller.dart';
import 'package:app/controllers/history/history_lecture_controller.dart';
import 'package:app/controllers/home/home_controller.dart';
import 'package:app/controllers/progress/progress_controller.dart';
import 'package:app/service/api/api_client.dart';
import 'package:app/service/repository/content_repo.dart';
import 'package:app/service/repository/guild_repo.dart';
import 'package:app/utils/router_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BindingInit implements Bindings {

  @override
  void dependencies() async {
    
    Get.lazyPut(() => APIRequestClient(RoutesConstants.baseUrl),fenix: true);
    // respos:
    Get.lazyPut(() => GuildRepo(apiRequestClient: Get.find()),fenix: true);
    Get.lazyPut(() => ContentRepo(apiRequestClient: Get.find()), fenix: true);


    // controllers:
    Get.put(AuthController());
    Get.lazyPut(() => BudgetItemController(), fenix: true);
    Get.lazyPut(() => GuildController(guildRepo: Get.find()), fenix: true);
    Get.lazyPut(() => ActivityControlller(contentRepo: Get.find()), fenix: true);
  
    Get.lazyPut(() => BudgetController(), fenix: true);
    Get.lazyPut(() => ProgressController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => HistoryController(),fenix: true);
    Get.lazyPut(() => HistoryLectureController(), fenix: true);
    Get.lazyPut(() => EmailVerificationController(), fenix: true);
    Get.lazyPut(() => AtributeProfileController(), fenix: true);

    Get.lazyPut(() => GoalsController(), fenix: true);
    Get.lazyPut(() => FinancialAccountController(), fenix: true);
  }
}