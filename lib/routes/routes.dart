import 'package:app/pages/auth/signin_page.dart';
import 'package:app/pages/auth/signup_page.dart';
import 'package:app/pages/budget/category_page.dart';
import 'package:app/pages/budget/category_pay.dart';
import 'package:app/pages/conf/settings_page.dart';
import 'package:app/pages/guild/guild_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/home_principal.dart';
import 'package:app/pages/question_page_initial/question_page.dart';
import 'package:app/pages/currency_select_page/currency_select_page.dart';
import 'package:app/pages/analytics/progress.dart';
import 'package:app/pages/splash/into/splash_screen_intro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouterHelper {

  static const String signup = "/signup-page";
  static const String signin = "/signin-page";
  static const String home = "/home-page";
  static const String homePrincipal = "/home-principal-page";
  static const String settings = "/setting-page";
  static const String progress = "/progress-page";
  static const String guild = "/guild-page";
  static const String categoryAccount = "/category-account-page";
  static const String categoryAccountPay = "/category-account-pay-page";
  static const String splash = "/splash";
  static const String question = "/question";
  static const String presentation = "/splash-intro";
  static const String divisa = "/divisa-page";

  // funciones de acceso externo
  static String getSignup() => signup;
  static String getSignin() => signin;
  static String getHomePage() => home;
  static String getSettingsPage() => settings;
  static String getProgressPage() => progress;
  static String getGuildPage() => guild;
  static String getHomePrincipalPage() => homePrincipal;
  static String getCategoryAccountPage() => categoryAccount;
  static String getCategoryAccountPayPage() => categoryAccountPay;
  static String getQuestion() => question;
  static String getPresentation() => presentation;
  static String getDivisa() => divisa;
  static String getSplash() => splash;


  static final List<GetPage> routes = [
    _getPage(signin, const SignInPage(), Transition.native),
    _getPage(signup, const SignUpPage(), Transition.native),
    _getPage(home, const HomePage(), Transition.fadeIn),
    _getPage(settings, const SettingsPage(), Transition.rightToLeft),
    _getPage(progress, ProgressPage(), Transition.native),
    _getPage(guild, const GuildPage(), Transition.native),
    _getPage(homePrincipal, const HomePagePrincipal(), Transition.native),
    _getPage(categoryAccount, const CategoryPage(), Transition.fade),
    _getPage(categoryAccountPay, const CategoryPayPage(), Transition.fade),
    //_getPage(splash, const SplashPage()),
    _getPage(question, const QuestionPage(), Transition.native),
    _getPage(presentation, const SplashScreenIntro()),
    _getPage(divisa, const CurrencySelectPage()),
  ];


  static GetPage _getPage(String name, Widget page, [Transition? transition]) {
    return GetPage(name: name, page: () => page, transition: transition);
  }

}