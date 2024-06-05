
import 'dart:async';

import 'package:app/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';


class EmailVerificationController extends GetxController {
  late AuthController _auth;
  late Timer _timer;


  @override
  void onInit() {
    _auth = Get.find<AuthController>();
    sendVerificationEmail();
    setTimerForAutoRedirect();
    super.onInit();
  } 

  void sendVerificationEmail() async {
    try {
      await _auth.sendEmailVerificationAccount();
    } catch (e) {
      print(e);
    }
  }
  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _auth.firebaseAuth.currentUser?.reload();
      final user = _auth.firebaseAuth.currentUser;
      if(user!.emailVerified) {
        timer.cancel();
        _auth.setInitialScreen(user);        
      }
    });
  }
  void manuallyCheckEmailVerificationStatus() {
    _auth.firebaseAuth.currentUser?.reload();
    final user = _auth.firebaseAuth.currentUser;
    if(user!.emailVerified) {
      _auth.setInitialScreen(user);        
    }
  }

}




