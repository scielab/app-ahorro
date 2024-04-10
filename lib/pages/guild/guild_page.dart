import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/staggered_gird_widget.dart';
import 'package:flutter/material.dart';


class GuildPage extends StatelessWidget {
  const GuildPage({super.key});
  final List<String> card = const ["Creditos","Ahorro","Invertir","Presupuestos","Finanzas","Legales"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Guilds"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: StaggeredDualWidet(itemCount: card.length,builder: (context,index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(card[index]),
            )
          );
        },
        spacing: 10,
        aspectRatio: 0.8,),
      )
    );
  }
}

