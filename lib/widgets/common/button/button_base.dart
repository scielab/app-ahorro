import 'package:app/utils/color_custom.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/utils/size_widget.dart';
import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  final String title;
  final bool primary;
  final SizeWidget sizeWidget;
  const ButtonBase({super.key,required this.title,this.primary = false,this.sizeWidget = SizeWidget.SMALL});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeWidget == SizeWidget.SMALL ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: primary ? AppColors.mainColor : AppColors.midColor,
      ),
      child: Center(
        child: Text(title,
          style: TextStyle(
            fontSize: Dimension.font18,
            fontWeight: FontWeight.bold,
            color: primary ? AppColors.midColor : AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}