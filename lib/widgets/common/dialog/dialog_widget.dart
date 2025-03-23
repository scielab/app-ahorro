import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final VoidCallback cancelFunction;
  final VoidCallback okFunction;
  final String title;
  final String description;

  const DialogWidget({super.key,required this.title, this.description='',required this.okFunction, required this.cancelFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BigText(title: title,over: true,),
      content: SmallText(title: description,over: true,),
      actions: <Widget> [
        TextButton(onPressed: () {
           Navigator.pop(context);
        }, child: const Text('Cancel')),
        TextButton(onPressed: okFunction, child: const Text('OK')),
      ],
    );
  }


}