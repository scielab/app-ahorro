

import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/material.dart';

class QuestionItem extends StatelessWidget {

  final String title;
  final VoidCallback callback;

  const QuestionItem({
    super.key,
    required this.title,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width * (1 - 0.20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: SmallText(title: title,size: Dimension.font16,fw: FontWeight.bold,over: true,),
      ),
    );
  }
}