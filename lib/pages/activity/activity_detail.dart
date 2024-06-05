import 'dart:io';
import 'package:app/controllers/history/history_lecture_controller.dart';
import 'package:app/models/content_model.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/dialog/custom_dialog_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';


class ActivityDetailPage extends StatefulWidget {
  final ContentModel content;
  const ActivityDetailPage({super.key,required this.content});

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  HistoryLectureController historyLectureController = Get.find<HistoryLectureController>();


  final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';
  late InterstitialAd? _interstitialAd;
  void loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
  @override
  void initState() {
    super.initState();

    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    ContentModel contentModel = widget.content;  // Esto se le pasa por parametro
    final size = MediaQuery.of(context).size;

    return OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Listo',
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0))),
        ),
        addButton : true, // Este es el button para seleccionar otro mas
        controllerColor: Colors.black,
        indicatorAbove : false,
        centerBackground: true,
        onFinish: () async {
          historyLectureController.updateResponseLecture(widget.content.id);
          // Agregar un sonido cuandon termina

          //SounedSing sounedSing = SounedSing();
          //sounedSing.playSound();
          showDialog(context: context, builder: (context) => CustomDialogWidget(
            title: "Lectura finalizada",callback: () {
              _interstitialAd!.show();            
              Get.back();
            }));
            
        },
        background: List.generate(contentModel.content.length, (index) {
          return Container(
            height: size.height * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Image.asset('assets/images/notebook.png'),
          );
        }),
        totalPage: contentModel.content.length,
        speed: 1.8,
        pageBodies: List.generate(contentModel.content.length, (index) {
          
          var data = contentModel.content;
          List<Widget> questionWidgets = [];

          for (var i in data[index].contentText) {
            questionWidgets.add(
                Container(
                  child: i.type == 'text' ? Text(i.text.toString(),
                        style: TextStyle(
                            fontSize: Dimension.font20,
                        
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.justify) : Math.tex(i.text, mathStyle: MathStyle.display,textStyle: TextStyle(fontSize: Dimension.font16,fontWeight: FontWeight.bold), ),
                ),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.33),
                  BigText(title: data[index].title,size: Dimension.font26,over: true,alig: true),
                  const SizedBox(height: 30,),
                  ...questionWidgets, // Puedo desestructurar una lista en todos sus elementos usando este codigo
                  //const SizedBox(height: 100,),
                ],
              ),
            ),
          );
        })
      
    );
  }
}



