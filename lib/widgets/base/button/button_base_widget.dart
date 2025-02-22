

import 'package:app/utils/dimension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonBaseWidget extends StatelessWidget {

  final String title;
  final Color colorBack;
  final Color colorText;
  final VoidCallback onPress;


  const ButtonBaseWidget({
    super.key,
    required this.title,
    this.colorBack = Colors.black,
    this.colorText = Colors.white,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      
        decoration: BoxDecoration(
          color: colorBack,
          borderRadius: BorderRadius.circular(10),
      
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: colorText,
              fontSize: Dimension.font18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}