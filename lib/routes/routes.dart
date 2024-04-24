import 'package:app/pages/auth/signin_page.dart';
import 'package:app/pages/auth/signup_page.dart';
import 'package:app/pages/budget/category_page.dart';
import 'package:app/pages/budget/category_pay.dart';
import 'package:app/pages/conf/settings_page.dart';
import 'package:app/pages/guild/guild_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/home_principal.dart';
import 'package:app/pages/intro/question_page.dart';
import 'package:app/pages/presentation/badge_page.dart';
import 'package:app/pages/progress/progress.dart';
import 'package:app/pages/splash/splash_screen.dart';
import 'package:app/pages/splash/splash_screen_intro.dart';
import 'package:get/get.dart';

class RouterHelper {
  
  static const String _signup = "/signup-page";
  static const String _signin = '/signin-page';
  static const String _home = '/home-page';
  static const String _homePrincipal = '/home-principal-page';
  static const String _settings = '/setting-page';
  static const String _progress = '/progress-page';
  static const String _guild = '/guild-page';
  static const String _category_account = '/category-account-page';
  static const String _category_account_pay = '/category-account-pay-page';

  static const String splash = '/splash';
  static const String question = '/question';  

  // Intro Splash
  static const String presentation = '/splash-intro';
  static const String divisa = '/divisa-page';
  

  static String getSignup() => _signup;
  static String getSignin() => _signin;
  static String getHomePage() => _home;

  static String getSettingsPage() => _settings;
  static String getProgressPage() => _progress;
  static String getGuildPage() => _guild;
  static String getHomePrincipalPage() => _homePrincipal;
  static String getCategoryAccountPage() => _category_account;
  static String getCategoryAccountPayPage() => _category_account_pay;

  static String getQuestion() => question;
  
  static String getPresentation() => presentation;
  static String getDivisa() => divisa;



  // Splash
  static String getSplash() => splash;

  static List<GetPage> routes = [
    GetPage(name: _signin, page: () => SignInPage(),transition: Transition.native),
    GetPage(name: _signup, page: () => SignUpPage(),transition: Transition.native),
    GetPage(name: _home, page: () => HomePage(),transition: Transition.fadeIn),
  
    GetPage(name: _settings, page: () => SettingsPage(),transition: Transition.native),
    GetPage(name: _progress, page: () => ProgressPage(),transition: Transition.native),
    GetPage(name: _guild, page: () => GuildPage(),transition: Transition.native),
    GetPage(name: _homePrincipal, page: () => const HomePagePrincipal(),transition: Transition.native),
    GetPage(name: _category_account, page: () => CategoryPage(),transition: Transition.native),
    GetPage(name: _category_account_pay, page: () => CategoryPayPage(), transition: Transition.native),
  
    GetPage(name: splash, page: () => SpashPage()),
    GetPage(name: question, page: () => QuestionPage(),transition: Transition.native),
  
  
    GetPage(name: presentation, page: () => SplashScreenIntro()),
    GetPage(name: divisa, page: () => BadgePage())
  ];
}