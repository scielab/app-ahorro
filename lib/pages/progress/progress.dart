import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/button_base_drop.dart';
import 'package:app/widgets/shopping_item.dart';
import 'package:app/widgets/tag_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Progress"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonBase(title: "Expenses",primary: true,),
                  ButtonBase(title: "Income"),
                  ButtonBaseDrop(title: "June"),
                ],
              ),
              const SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 0,
                    sectionsSpace: 10,
                    sections: [
                      PieChartSectionData(
                        value: 30,
                        title: 'Comida',
                        showTitle: true,
                        radius: 120,
                        color: const Color.fromARGB(255, 171, 223, 255),
                      ),
                      PieChartSectionData(
                        value: 40,
                        title: 'Arriendo',
                        showTitle: true,
                        radius: 120,
                        color: const Color.fromARGB(255, 255, 102, 102),
                      ),
                      PieChartSectionData(
                        value: 10,
                        title: 'Viajes',
                        showTitle: true,
                        radius: 120,
                        color: const Color.fromARGB(255, 212, 255, 102),
                      ),
                      PieChartSectionData(
                        value: 20,
                        title: 'Internet',
                        showTitle: true,
                        radius: 120,
                        color: const Color.fromARGB(255, 106, 255, 96),
                      ),
                    ],
                  )
                ),
              ),
              const SizedBox(height: 30,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  TagResult(title: "Day", value: "52"),
                  Spacer(),
                  TagResult(title: "Day", value: "52"),
                  Spacer(),
                  TagResult(title: "Day", value: "52"),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: const Column(
                  children: [
                    ShoppingItem(title: "Shopping", category: "Cash", value: "498.50", porcent: "32%", icon: Icons.shopping_basket, colorIcon: Colors.green),
                    ShoppingItem(title: "Gifts", category: "Cash", value: "498.50", porcent: "21%", icon: Icons.card_giftcard_rounded, colorIcon: Colors.pink),
                    ShoppingItem(title: "Food", category: "Cash", value: "498.50", porcent: "12%", icon: Icons.food_bank, colorIcon: Colors.orange),
                    ShoppingItem(title: "Shopping", category: "Cash", value: "498.50", porcent: "32%", icon: Icons.shopping_basket, colorIcon: Colors.green),
                    ShoppingItem(title: "Gifts", category: "Cash", value: "498.50", porcent: "21%", icon: Icons.card_giftcard_rounded, colorIcon: Colors.pink),
                    ShoppingItem(title: "Food", category: "Cash", value: "498.50", porcent: "12%", icon: Icons.food_bank, colorIcon: Colors.orange),
                  ],
                ),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}