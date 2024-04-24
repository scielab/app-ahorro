import 'package:app/pages/activity/activity_detail.dart';
import 'package:app/widgets/base/card/card_primary_widget.dart';
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
    //"Invertir",
    //"Activos",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Matish"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.notifications_sharp,size: 30,),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.person,size: 30,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SmallText(title: "Tu plan para hoy"),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: List.generate(
                    items.length,
                    (index) => GestureDetector(
                          onTap: () {
                            Get.to(() => const ActivityDetailPage());
                          },
                          child: CardPrimeryWidget(
                            title: items[index],
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

