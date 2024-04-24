
import 'package:app/models/question_model.dart';
import 'package:app/pages/splash/splash_screen_intro.dart';
import 'package:app/routes/routes.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/question/question_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// informacion de las animaciones
var _duration = const Duration(milliseconds: 500);


class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late List<QuestionModel> question;

  bool isFinish = false;
  late int _currentState = 0;
  // donde guardar las respuestas del codigo

  @override
  void initState() {
    question = questions_data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  // desaparcer todas las que no son del index y vamos aumentar el index cuando se presional el boton

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[200],
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
            child: Stack(
              children: List.generate(question.length, (index) {

                var data = question[index];
                print(question.length);
                //print(index);
                return AnimatedOpacity(
                  opacity: _currentState == index ? 1.0 : 0.0,
                  duration: _duration,
                  curve: Curves.easeInOut,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      BigText(title: data.title,size: 30,color: Colors.white,alig: true),
                      const SizedBox(height: 50,),
                      ...List.generate(data.alternatives.length, (indexSub) => QuestionItem(title: data.alternatives[indexSub], callback: () {
                        if(_currentState < (question.length - 1)) {
                          _currentState++;
                          print(_currentState);
                        } else {
                          //Get.to(() => const SplashScreenIntro()); 
                          Get.offNamed(RouterHelper.getDivisa());
                        }
                        setState(() {});
                      }),),
                      const Spacer(),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}