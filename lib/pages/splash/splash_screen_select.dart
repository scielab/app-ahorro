import 'package:app/controllers/activity/activity_controller.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/question/question_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashSreenSelect extends StatelessWidget {
  const SplashSreenSelect({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var activityControlller = Get.put(ActivityControlller());
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BigText(title: "Nivel de conocimiento en educacion financiera",size: Dimension.font26,color: Colors.white,alig: true,over: true),
                  const SizedBox(height: 40,),
                  QuestionItem(title: "Basico", callback: () {
                    activityControlller.selectDificulty('beginner');
                    Get.offNamed(RouterHelper.getHomePrincipalPage());
                  }),
                  QuestionItem(title: "Intermadio", callback: () {
                    activityControlller.selectDificulty('intermediate');
                    Get.offNamed(RouterHelper.getHomePrincipalPage());
                  }),
                  QuestionItem(title: "Avanzado", callback: () {
                    activityControlller.selectDificulty('advanced');
                    Get.offNamed(RouterHelper.getHomePrincipalPage());
                  }),
                ],
              ),
            )
          ],
      ),
    );
  }
}