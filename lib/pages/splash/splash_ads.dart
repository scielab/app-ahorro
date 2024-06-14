
import 'package:app/utils/color_custom.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class SplashAds extends StatelessWidget {
  const SplashAds({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
            children: [
              /*
              SizedBox(
                width: size.width,
                height: size.height,
                child: const Image(image: AssetImage('assets/images/winter_back.jpg'), fit: BoxFit.cover,alignment: Alignment.centerRight,),
              ),
              */
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    const Expanded(
                      flex: 3,
                      child: Image(image: AssetImage("assets/splash/ads.png"))
                    ),
                    Expanded(
                      flex: 1,
                      child: BigText(title: "Nos Puedes ayudar viendo un Anuncio",size: Dimension.font26,over: true, alig: true,),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Get.to(() => const SplashScreenLoader());
                            },
                            child: Container(
                              width: size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue[700],
                                borderRadius: const BorderRadius.all(Radius.circular(10))
                              ),
                              child: Center(
                                child: SmallText(title: "VER ANUNCIO",fw: FontWeight.bold,color: Colors.white,size: Dimension.font18,),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          BigText(title: "Continuar sin ver Anuncio",size: Dimension.font18,color: AppColors.contentColorBlue,),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }
}