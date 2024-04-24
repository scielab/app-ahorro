import 'package:app/models/content_model.dart';
import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';

import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';


class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({super.key});
  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {

  @override
  Widget build(BuildContext context) {
    ContentModel contentModel = contents[0];  // Esto se le pasa por parametro
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
        onFinish: () =>  Get.back(),
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
                  margin: const EdgeInsets.only(bottom: 10),
                  child: i.type == 'text' ? Text(i.text.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center) : Math.tex(i.text, mathStyle: MathStyle.display,textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
                ),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 350),
                  BigText(title: data[index].title),
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



