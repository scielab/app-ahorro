

import 'package:app/utils/dimension.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/material.dart';

class TagProgress extends StatelessWidget {
  final String text;
  final String icon;
  final String value;

  const TagProgress({
    required this.icon,
    required this.text,
    required this.value,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          children: [
            Image.asset(icon,width: 30,),
            SizedBox(width: Dimension.width10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(title: value,size: Dimension.font18,),
                SmallText(title: text,size: Dimension.font16,),
              ],
            )
          ],
        )
      ),
    );
  }
}