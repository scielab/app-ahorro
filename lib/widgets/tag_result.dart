import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
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
            SmallText(title: title),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$',style: TextStyle(color: Colors.grey[500]),),
                BigText(title: "$value",size: 18,),
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