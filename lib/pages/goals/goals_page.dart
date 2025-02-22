
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/goals/goals_controller.dart';
import 'package:app/models/goals_model.dart';
import 'package:app/pages/goals/goals_add_page.dart';
import 'package:app/pages/goals/goals_detail_page.dart';
import 'package:app/widgets/base/tag/tag_default_empty_widget.dart';
import 'package:app/widgets/base/tag/tag_empty_widget.dart';
import 'package:app/widgets/base/tag/tag_item_goals_widget.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  bool light = true;

  // Traer la informacion de usuario desde aqui
  final GoalsController goalsController = Get.find<GoalsController>();
  late String userid = Get.find<AuthController>().getCurrentUser()!.uid;
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Metas"),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => GoalsAddPage(userid: userid,));
            },
            child: const SmallText(title: "+ Agregar cuenta")),
          const SizedBox(width: 20,),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10,),
          // comprobar si esto esta vacio o no
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // tarjet aquii
                TagEmptyWidget(),
                TagEmptyWidget(),
              ],
            ),
            const SizedBox(height: 30,),
            FutureBuilder(
              future: goalsController.getGoalsByUserId(userid), 
              builder: (context, snapshot ){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {

                  final data = snapshot.data;
                  if(data != null && data.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                          
                          final GoalsModel goalsModelCurrent = snapshot.data![index];
                          return TagItemGoalWidget(onPress: () {
                            Get.to(GoalsDetailPage(goalsModel: goalsModelCurrent));
                          }, goalsModel: goalsModelCurrent,);
                        }),
                      );
                  
                  } else {
                    return Center(
                      child: TagDefaultEmptyWidget(image: 'assets/svg/svg1.svg',textPrincipal: "Tocar para Crear",textSecondary: "Sin objetivos establecidos",onPress: () {
                        Get.to(() => GoalsAddPage(userid: userid));
                      },),
                    );
                  }                
                }
                return Center(
                  child: TagDefaultEmptyWidget(image: 'assets/svg/svg1.svg',textPrincipal: "Tocar para Crear",textSecondary: "Sin objetivos establecidos",onPress: () {
                    Get.to(() => GoalsAddPage(userid: userid));
                  },),
                );
              }

            ),
                        
          ],
        ),
      ),
    );


  }
}




