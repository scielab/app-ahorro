import 'package:app/pages/guild/guild_steps_page.dart';
import 'package:app/widgets/base/card/card_secundary_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/search/custom_delegate.dart';
import 'package:app/widgets/staggered_gird_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GuildPage extends StatelessWidget {
  const GuildPage({super.key});
  final List<String> card = const ["Creditos","Ahorro","Invertir","Presupuestos","Finanzas","Legales"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Happy Learn",size: 25,),
        actions: [
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomDelegate(
                  searchFieldLabel: 'Buscar...',
                  searchFieldStyle: const TextStyle(fontSize: 16.0),
                  searchFieldDecorationTheme:
                      const InputDecorationTheme(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.search,size: 30,)),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10,right: 10,top: 20),
        child: StaggeredDualWidet(itemCount: card.length,builder: (context,index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const GuildStepsPage());
            },
            child: CardSecundaryWidget(title: card[index],));
        },
        spacing: 10,
        aspectRatio: 0.8,),
      )
    );
  }
}

