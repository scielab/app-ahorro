
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final FontWeight fw;

  const SmallText({super.key,required this.title, this.size=15,this.color=Colors.black,this.fw=FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(title,
    textAlign: TextAlign.start,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fw,
    ),);
  }
}