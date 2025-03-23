

import 'package:app/helpers/shared_preferences_services.dart';
import 'package:app/routes/routes.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenLoader extends StatefulWidget {
  const SplashScreenLoader({super.key});

  @override
  State<SplashScreenLoader> createState() => _SplashScreenLoaderState();
}

class _SplashScreenLoaderState extends State<SplashScreenLoader> {

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 3),() async {
      bool isQuestion = Get.find<SharedPrefsService>().getBool('question') ?? false;
      if(isQuestion) { 
        Get.offNamed(RouterHelper.getDivisa());
      } else {
        Get.toNamed(RouterHelper.getQuestion());
      }
    });    
  }

  // Este va a cargar un Svg
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: const Color.fromARGB(255, 41, 56, 138),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        child: Image.asset(
                          width: size.width * 0.6,
                          "assets/splash/splashloader.gif"
                        ),
                      ),
                    ),              
                    const BigText(title: "Espere...",color: Colors.white,size: 22,),
                    const SizedBox(height: 100,),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}