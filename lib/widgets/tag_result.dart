import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/material.dart';

class TagResult extends StatelessWidget {
  final String title;
  final String value;

  const TagResult({super.key,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            SmallText(title: title,size: Dimension.font16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$',style: TextStyle(color: Colors.grey[500]),),
                BigText(title: "$value",size: Dimension.font16),
              ],
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
    );
  }
}