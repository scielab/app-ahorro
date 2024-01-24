import 'package:app/pages/auth/signin_page.dart';
import 'package:app/pages/auth/signup_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:get/get.dart';

class RouterHelper {
  
  static const String signup = "/signup-page";
  static const String signin = '/signin-page';
  static const String home = '/home-page';

  static String getSignup() => signup;
  static String getSignin() => signin;
  static String getHomePage() => home;

  static List<GetPage> routes = [
    GetPage(name: signin, page: () => SignInPage()),
    GetPage(name: signup, page: () => SignUpPage()),
    GetPage(name: home, page: () => HomePage(),transition: Transition.fadeIn),
  ];
}