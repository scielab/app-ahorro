import 'package:app/utils/dimension.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';


class CardPrimeryWidget extends StatelessWidget {
  final String title;

  const CardPrimeryWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: size.width,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: const Offset(0, 3),
              blurRadius: 7.0,
              spreadRadius: 2,
            ),
          ]),
      child: Stack(
        children: [
          const Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child:  Row(
                children: [
                  Spacer(),
                  Icon(
                    Icons.calendar_month,
                    color: Colors.black54,
                    size: 15,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  SmallText(
                    title: "3 Aug 23",
                    color: Colors.black54,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 25,
            child: SizedBox(
              width: size.width * 0.7,
              child: BigText(
                title: title,
                size: Dimension.font20,
              ),
            ),
          ),
          SmallText(
            size: Dimension.font16,
            title: "2 min lectura",
            color: Colors.black54,
          ),

          const Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: ButtonCardWidget(),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: 2,
                  color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}

class ButtonCardWidget extends StatelessWidget {
  const ButtonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimension.height45,
      height: Dimension.height45,
      decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: const Center(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.black,
        ),
      ),
    );
  }
}
