import 'package:app/controllers/guild/guild_controller.dart';
import 'package:app/models/content_model.dart';
import 'package:app/models/guild_model.dart';
import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';

class GuildDetailPage extends StatefulWidget {
  const GuildDetailPage({super.key});

  @override
  State<GuildDetailPage> createState() => _GuildDetailPageState();
}

class _GuildDetailPageState extends State<GuildDetailPage> {
  final guildController = Get.find<GuildController>();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      guildController.loadJsonData();
    });
    super.initState();
  }

  //Map<int, bool> selectedOptions = {};
  Map<int, int?> selectedOptions = {}; // seleccionamos pregunta con alternativa para manejar el estadi
  bool showButton = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      var data = guildController.datalist[0];

      return guildController.isLoading
          ? OnBoardingSlider(
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
                } else {
                  Get.snackbar("Respuesta", "¡Tiene respuestas incorrectas");
                }
              },
              background: List.generate(data.length, (index) {
                return data[index].type == 'content' ?  Container(
                  height: size.height * 0.3,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Image.asset('assets/images/notebook.png'),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList();
                } else {
                 
                  contentEntry = data[index] as QuestionEntry;
                  alternatives = contentEntry.options.map((option) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {

                          // selectedOptions.forEach((key, value) {
                          //   selectedOptions[key] = false;
                          // });

                          // selectedOptions[option.id] = true;
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
                        child: BigText(title: option.option),
                      ),
                    );
                  }).toList();
                }


                return isContent ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 350),
                        BigText(title: contentEntry.title),
                        const SizedBox(
                          height: 30,
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
                          child: BigText(title: contentEntry.question)),
                        const SizedBox(
                          height: 30,
                        ),
                        ...alternatives, // Puedo desestructurar una lista en todos sus elementos usando este codigo
                        const SizedBox(height: 100,),
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
              }))
          : const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
    });
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
        Get.snackbar("Respuesta", "¡Respuesta correcta!",
          snackPosition: SnackPosition.BOTTOM);
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
