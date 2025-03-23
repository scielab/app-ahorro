import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/button/button_base.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';



class SpashPage extends StatelessWidget {
  const SpashPage({super.key});

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50,),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 100),
              child: Image.asset(
                width: 100,
                "assets/splash/splash.gif"
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: BigText(title: "Estamos comenzando..."),
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.blue[600],
              ),
              child: const Center(child: BigText(title: "Continuar",color: Colors.white,)),
            ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}