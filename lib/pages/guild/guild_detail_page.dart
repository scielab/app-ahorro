import 'dart:io';
import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/models/guild_model.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/dialog/custom_dialog_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GuildDetailPage extends StatefulWidget {
  final Module currentLesson;
  const GuildDetailPage({super.key,required this.currentLesson});

  @override
  State<GuildDetailPage> createState() => _GuildDetailPageState();
}

class _GuildDetailPageState extends State<GuildDetailPage> {
  final guildController = Get.find<GuildController>();

  Map<int, int?> selectedOptions = {}; // seleccionamos pregunta con alternativa para manejar el estadi
  bool showButton = true;

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
    final size = MediaQuery.of(context).size;
    var data = widget.currentLesson.entries;

    return OnBoardingSlider(
              headerBackgroundColor: Colors.white,
              finishButtonText: 'Listo',
              finishButtonStyle: const FinishButtonStyle(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
              ),
              addButton: true, // Este es el button para seleccionar otro mas
              controllerColor: Colors.black,
              indicatorAbove: false,
              centerBackground: true,
              onFinish: () {
                if(_checkAnswerFinish(data)) {
                  Get.back();
                  Get.snackbar("Respuesta", "¡Correcto modulo finalizado");
                  guildController.finishLessonHistory(widget.currentLesson.id);
                  _interstitialAd!.show();
                } else {
                  Get.snackbar("Respuesta", "¡Tiene respuestas incorrectas");
                }
              },
              background: List.generate(data.length, (index) {
                return (data[index].type == 'content') && ((data[index] as ContentEntry).imageUrl.isNotEmpty)  ?  Container(
                  height: size.height * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image.asset((data[index] as ContentEntry).imageUrl),
                ) : Container();
              }),
              totalPage: data.length,
              speed: 1.8,
              pageBodies: List.generate(data.length, (index) {
                
                bool isContent = data[index].type == 'content';
                var contentEntry;
                List<dynamic> contentWidgets = [];
                List<dynamic> alternatives = [];

                if(isContent) {
                  contentEntry = data[index] as ContentEntry;

                  contentWidgets = contentEntry.content.map((paragraph) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        paragraph,
                        style: TextStyle(
                          fontSize: Dimension.font16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    );
                  }).toList();
                } else {
                 
                  contentEntry = data[index] as QuestionEntry;
                  alternatives = contentEntry.options.map((option) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOptions[data[index].id] = option.id;
                        });
                      },
                      child: Container(
                        width: size.width,
                        margin: const EdgeInsets.only(bottom: 10,left: 30,right: 30),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: selectedOptions[data[index].id] == option.id ? Border.all(color: Colors.blue, width: 3.0) : null,
                        ),
                        child: BigText(title: option.option,size: Dimension.font18,over: true),
                      ),
                    );
                  }).toList();
                }


                return isContent ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        if((contentEntry as ContentEntry).imageUrl.isNotEmpty) SizedBox(height: size.height * 0.33),
                        BigText(title: contentEntry.title,size: Dimension.font20,over: true,alig: true,),
                        const SizedBox(
                          height: 20,
                        ),
                        ...contentWidgets, // Puedo desestructurar una lista en todos sus elementos usando este codigo
                        //const SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ) : SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 50),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10,left: 30,right: 30),
                          child: BigText(title: contentEntry.question,size: Dimension.font20,over: true,alig: true,)),
                        const SizedBox(
                          height: 30,
                        ),
                        ...alternatives, // Puedo desestructurar una lista en todos sus elementos usando este codigo
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            // confirmation
                            _checkAnswer(contentEntry);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10,left: 30,right: 30),
                            padding: const EdgeInsets.all(10),
                            width: size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.blue,
                            ),
                            child: const Center(
                              child: BigText(title: "Comprobar",color: Colors.white,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
          }
      ),
    );
  }

bool _checkAnswerFinish(List<Entry> datalist) {
  int contQuestion = 0;
  int contCorrectQuestion = 0;
  for(var data in datalist) {
    if(data is QuestionEntry) {
      contQuestion++;
      final selectedOptionId = selectedOptions[data.id];
      final correctOption = data.options.firstWhere((element) => element.isCorrect);
      if (selectedOptionId != null && correctOption != null) {
        if (selectedOptionId == correctOption.id) {
          contCorrectQuestion++;
        } else {
           return false;
        }
      }
    }
  }
  if(contQuestion == contCorrectQuestion) {
    return true;
  } else {
    return false;
  }
}

void _checkAnswer(dynamic contentEntry) {
  if (contentEntry is QuestionEntry) {
    final selectedOptionId = selectedOptions[contentEntry.id];
    final correctOption = contentEntry.options.firstWhere((option) => option.isCorrect);

    if (selectedOptionId != null && correctOption != null) {
      if (selectedOptionId == correctOption.id) {
        // Respuesta correcta
        showDialog(context: context, builder: (context) => const CustomDialogWidget(title: "Respuesta Correcta",));
        // Get.snackbar("Respuesta", "¡Respuesta correcta!",
        //   snackPosition: SnackPosition.BOTTOM);
      } else {
        // Respuesta incorrecta
        Get.snackbar("Respuesta", "Respuesta incorrecta, intenta de nuevo.",
          snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      // No se ha seleccionado ninguna opción
      Get.snackbar("Respuesta", "Debes seleccionar una opción antes de comprobar.",
        snackPosition: SnackPosition.BOTTOM);
    }
  }
}

}
