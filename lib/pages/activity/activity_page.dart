import 'package:app/pages/activity/activity_detail.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<String> items = [
    "Creditos Bancarios",
    "Presupuesto Personal",
    "Invertir",
    "Activos",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Actividades"),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const BigText(title: "Chose you Course"),
                const SizedBox(height: 20,),
                Column(
                  children:List.generate(items.length, (index) => 
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ActivityDetailPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/login_back.jpeg"),fit: BoxFit.cover, alignment: Alignment.bottomRight),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.black,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 160,
                              left: 20,
                              child: SmallText(title: items[index],size: 20,color: Colors.white,fw: FontWeight.bold,),
                            ),
                          ],
                        ),
                                      ),
                    )),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}