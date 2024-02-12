import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BudgetDetailPage extends StatelessWidget {
  const BudgetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SmallText(title: "Detalle de transferencia"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            BigText(title: "Income"),
            SmallText(title: "10000"),
            SmallText(title: "Date"),
          ],
        ),
      ),
    );
  }
}