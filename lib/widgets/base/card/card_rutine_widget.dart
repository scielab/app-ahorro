import 'package:app/utils/color_custom.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/material.dart';

class CardRutinePrimeryWidget extends StatelessWidget {
  final String title;
  final bool done;
  const CardRutinePrimeryWidget({super.key,required this.title,this.done = true});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Color.fromARGB(255, 235, 237, 255)!)
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: AppColors.contentColorBlue),
                ),
              ),
              if(done) 
              const SizedBox(
                width: 30,
                height: 30,
                child: Icon(Icons.check,  color: AppColors.contentColorBlue),
              ),
            ],
          ),
          const SizedBox(width: 20),
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
          //const Spacer(),
          //const Icon(Icons.arrow_forward_ios),
  
        ],
      ),
    );
  }
}