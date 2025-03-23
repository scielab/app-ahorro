

import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final FontWeight fw;
  final bool alig;
  final bool over;
  const BigText({super.key,required this.title, this.size=20,this.color=Colors.black,this.fw=FontWeight.bold,this.alig = false,this.over = false});

  @override
  Widget build(BuildContext context) {
    return Text(title,
    textAlign: alig ? TextAlign.center : TextAlign.start,
    overflow: over ? TextOverflow.clip : TextOverflow.ellipsis,
    style: TextStyle(
      decoration: TextDecoration.none,
      color: color,
      fontSize: size,
      fontWeight: fw,
    ),
    //softWrap: true,
    );
  }
}