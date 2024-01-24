

import 'package:app/widgets/button_base.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(Icons.arrow_back_ios),
            Text("December"),

            // charts
            ButtonBase(title: "Expenses"),
            ButtonBase(title: "Income"),
          ],
        ),
      ),
    );
  }
}