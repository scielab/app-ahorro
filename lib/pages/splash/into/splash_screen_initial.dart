import 'package:app/pages/auth/signin_page.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreenInitial extends StatefulWidget {
  const SplashScreenInitial({super.key});

  @override
  State<SplashScreenInitial> createState() => _SplashScreenInitialState();
}

class _SplashScreenInitialState extends State<SplashScreenInitial> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => const SignInPage());
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color.fromARGB(255, 204, 211, 218), Colors.purple],begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, size: 80,color: Colors.white,),
            SizedBox(height: 20,),
            BigText(title: "Flutter Tips"),
          ],
        )
      ),
    );
  }
}
