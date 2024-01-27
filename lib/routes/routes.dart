import 'package:app/pages/auth/signin_page.dart';
import 'package:app/pages/auth/signup_page.dart';
import 'package:app/pages/conf/settings_page.dart';
import 'package:app/pages/guild/guild_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/progress/progress.dart';
import 'package:get/get.dart';

class RouterHelper {
  
  static const String _signup = "/signup-page";
  static const String _signin = '/signin-page';
  static const String _home = '/home-page';

  static const String _settings = '/setting-page';
  static const String _progress = '/progress-page';
  static const String _guild = '/guild-page';

  static String getSignup() => _signup;
  static String getSignin() => _signin;
  static String getHomePage() => _home;

  static String getSettingsPage() => _settings;
  static String getProgressPage() => _progress;
  static String getGuildPage() => _guild;


  static List<GetPage> routes = [
    GetPage(name: _signin, page: () => SignInPage(),transition: Transition.native),
    GetPage(name: _signup, page: () => SignUpPage(),transition: Transition.native),
    GetPage(name: _home, page: () => HomePage(),transition: Transition.fadeIn),
  
    GetPage(name: _settings, page: () => SettingsPage(),transition: Transition.native),
    GetPage(name: _progress, page: () => ProgressPage(),transition: Transition.native),
    GetPage(name: _guild, page: () => GuildPage(),transition: Transition.native),

  ];
}