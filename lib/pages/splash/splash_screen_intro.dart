

import 'package:app/pages/splash/splash_screen_loader.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
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
            child: const Image(image: AssetImage('assets/images/login_back.jpeg'),fit: BoxFit.cover,),
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
                const BigText(title: "No es magia.",color: Colors.white,size: 42,),
                const BigText(title: "Solo es Ciencia.",color: Colors.white,size: 35,),
                const SizedBox(height: 20,),
                const SmallText(title: "Creado por expertos en cambio conductual",color: Colors.white,),
                const SmallText(title: "Tal y como aparece",color: Colors.white,),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SplashScreenLoader());
                  },
                  child: Container(
                    width: size.width,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
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