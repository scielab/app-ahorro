

import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';


class TagDefaultEmptyWidget extends StatelessWidget {
  final String image;
  final String textPrincipal;
  final String textSecondary;
  final VoidCallback onPress;

  const TagDefaultEmptyWidget({super.key, required this.image, this.textPrincipal="", this.textSecondary = "", required this.onPress});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            semanticsLabel: 'Ejemplo SVG',
            width: size.width * 0.5, 
            height: size.width * 0.5, 
          ),
          SmallText(title: textSecondary),
          GestureDetector(
            onTap: () {
              onPress();
            },
            child: BigText(title: textPrincipal)),
        ],
      ),
    );
  }
}