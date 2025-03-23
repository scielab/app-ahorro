import 'package:app/utils/dimension.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/material.dart';

class CustomDialogWidget extends StatelessWidget {
  final String title;
  final VoidCallback? callback;
  const CustomDialogWidget({super.key,required this.title,this.callback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/checked.png',width: 72,),
            const SizedBox(height: 24,),
            BigText(title: title),
            const SizedBox(height: 24,),
            GestureDetector(
              onTap: () {
                if(callback != null) {
                  callback!();
                }
                Navigator.pop(context);
              },
              child: SmallText(title: "Continuar",size: Dimension.font20,color: Colors.blue,)),
            const SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
}