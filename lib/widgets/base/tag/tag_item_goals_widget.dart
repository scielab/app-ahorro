

import 'package:app/models/goals_model.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TagItemGoalWidget extends StatelessWidget {

  final GoalsModel goalsModel;
  final VoidCallback? onPress;
  const TagItemGoalWidget({super.key,this.onPress, required this.goalsModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(onPress != null) {
          onPress!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          
        ),
        child: Row(
          children: [
            const Icon(Icons.card_membership_outlined),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(title: goalsModel.name,size: Dimension.font16,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SmallText(title: goalsModel.notes,size: Dimension.font16,over: true,)),
              ],
            ),
            const Spacer(),
            BigText(title: "${goalsModel.ammount} CLP",size: Dimension.font16,),
          ],
        ),
      ),
    );
  }
}