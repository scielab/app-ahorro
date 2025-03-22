
import 'package:app/pages/splash/loaders/splash_screen_loader.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenIntro extends StatelessWidget {
  const SplashScreenIntro({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: const Image(image: AssetImage('assets/images/login_back.jpg'),fit: BoxFit.cover,),
          ),
          Container(
            width: size.width,
            height: size.height,
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const BigText(title: "La Libertad de la Educación Financiera.",color: Colors.white,size: 42,over: true,),
                const SizedBox(height: 20,),
                const SmallText(title: "Aprende, ahorra y prospera",color: Colors.white,),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SplashScreenLoader());
                  },
                  child: Container(
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: const Center(
                      child: SmallText(title: "Continuar",fw: FontWeight.bold,color: Colors.white,size: 25,),
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}