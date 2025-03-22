

import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class TagEmptyWidget extends StatelessWidget {
  const TagEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          SmallText(title: "Total", color: Colors.white,),
          BigText(title: "0.00",color: Colors.white,),
        ],
      ),
    );
  }
}