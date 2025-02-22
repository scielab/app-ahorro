import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/history/history_atributes_profile.dart';
import 'package:app/controllers/progress/progress_controller.dart';
import 'package:app/models/user_model.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:app/widgets/base/charts/chartsWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/utils/color_custom.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/progress/tag_progress.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProgressController progressController = Get.find<ProgressController>();
  final AtributeProfileController atributeProfileController = Get.find<AtributeProfileController>();

  late AuthController authController;
  late final userProfile;
  @override
  void initState() {
    authController = Get.find<AuthController>();
    userProfile = authController.getCurrentUser();
    //atributeProfileController.getAtributeProfile(userProfile!.uid);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  // Data la traigo desde el backend de la aplicacion
  List<dynamic> data = [
    {
      "icon": "assets/icons/energy.png",
      "value": "12",
      "text": "Energy",
    },
    {
      "icon": "assets/icons/medal.png",
      "value": "2",
      "text": "Guias",
    },
    {
      "icon": "assets/icons/trofeo.png",
      "value": "20",
      "text": "Lecturas",
    },
    {
      "icon": "assets/icons/graduation.png",
      "value": "Novicio",
      "text": "Division",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Perfil"),
        actions: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouterHelper.getSettingsPage());
            },
            child: Container(
              margin: EdgeInsets.only(right: Dimension.width15),
              child: Icon(Icons.settings,color: AppColors.contentColorBlue,size: Dimension.height30,),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.network(width: Dimension.screenWidth * 0.25,"https://cdn.icon-icons.com/icons2/2643/PNG/512/male_man_people_person_avatar_white_tone_icon_159363.png"),
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: AppColors.contentColorBlue,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 2, color: Colors.white),
                                ),
                                child: const Icon(Icons.edit,color: Colors.white,),
                              )
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: BigText(title: userProfile.name,size: Dimension.font20, alig: true,),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                BigText(title: "Estadísticas de Aprendizaje.",size: Dimension.font18,),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child:  GridView.builder(
                      shrinkWrap: false,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing : 8,
                      ), 
                      itemBuilder: (BuildContext context, int index) {
                        return TagProgress(icon: data[index]['icon'],text: data[index]['text'], value: data[index]['value']);
                      },
                    itemCount: 4,
                  ),
                ),
                BigText(title: "Estadísticas de tu Presupuesto mensual",over: true,size: Dimension.font18,),
                // Column(
                //     children: [
                //       BigText(title: "Estadísticas de tu Presupuesto mensual",over: true,size: Dimension.font18,),
                //       const SizedBox(height: 10,),
                //       const Center(
                //         child: ProgressWidget(),
                //       )
                //     ],
                //   ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(0, 3),
                            blurRadius: 7.0,
                            spreadRadius: 5,
                          ),
                        ],
                        color: AppColors.contentColorWhite,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(title: "Ingreso",size: Dimension.font16,),
                          BigText(title: "CLP ${formatNumberEnglish(progressController.getTotalAmmountMonh('income'))}",size: Dimension.font18,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.contentColorWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(0, 3),
                            blurRadius: 7.0,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(title: "Gasto",size: Dimension.font16,),
                          BigText(title: "CLP ${formatNumberEnglish(progressController.getTotalAmmountMonh('expense'))}",size: Dimension.font18,),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),            
                BigText(title: "Posible Ahorro del mes: CLP ${formatNumberEnglish(progressController.getAllAmmount().toString())}",size: Dimension.font16,over: true),
                const SizedBox(height: 20,),  
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.contentColorWhite,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade100,
                        offset: const Offset(0, 3),
                        blurRadius: 7.0,
                        spreadRadius: 5,
                      ),
                    ]
                  ),
                  child: const ChartsWidget(),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}