

import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final FontWeight fw;
  const BigText({super.key,required this.title, this.size=20,this.color=Colors.black,this.fw=FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(title,
    textAlign: TextAlign.start,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fw
    ),);
  }
}