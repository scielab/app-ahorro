

import 'package:app/routes/routes.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenLoader extends StatefulWidget {
  const SplashScreenLoader({super.key});

  @override
  State<SplashScreenLoader> createState() => _SplashScreenLoaderState();
}

class _SplashScreenLoaderState extends State<SplashScreenLoader> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4),() {
      Get.toNamed(RouterHelper.getQuestion());
      //Get.offNamed(RouterHelper.getDivisa());
    });
    super.initState();
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    child: Image.asset(
                      width: size.width * 0.6,
                      "assets/splash/splash.gif"
                    ),
                  ),
                ),              
                const BigText(title: "No es magia.",color: Colors.white,size: 22,),
                const BigText(title: "Solo es Ciencia.",color: Colors.white,size: 22,),
                const SizedBox(height: 30,),
                Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Center(
                    child: SmallText(title: "Continuar",fw: FontWeight.bold,color: Colors.white,size: 25,),
                  ),
                ),
                const SizedBox(height: 50,),
              ],
            ),
          ),
        ],
      )
    );
  }
}