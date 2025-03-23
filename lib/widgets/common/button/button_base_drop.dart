import 'package:app/utils/color_custom.dart';
import 'package:flutter/material.dart';

class ButtonBaseDrop extends StatelessWidget {
  final String title;
  final bool primary;

  const ButtonBaseDrop({super.key, required this.title, this.primary = false});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: primary ? AppColors.mainColor : AppColors.midColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title,
            style: TextStyle(
              color: primary ? AppColors.midColor : AppColors.mainColor,
            ),
          ),
          Icon(Icons.arrow_drop_down, color: primary ? AppColors.midColor : AppColors.mainColor,)
        ],
      )
    );
  }
}