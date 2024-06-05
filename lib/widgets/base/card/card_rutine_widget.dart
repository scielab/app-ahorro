import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class CardRutinePrimeryWidget extends StatelessWidget {
  final String title;

  const CardRutinePrimeryWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
            child: const Icon(Icons.done_all_sharp,color: Colors.white,),
          ),
          const SizedBox(width: 10,),
          SizedBox(
            width: size.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(title: title,size: Dimension.font16,over: true,),
                SmallText(title: "Completar",size: Dimension.font16,),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}