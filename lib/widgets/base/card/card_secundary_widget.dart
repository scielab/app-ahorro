
import 'package:app/widgets/base/card/card_primary_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class CardSecundaryWidget extends StatelessWidget {
  final String title;

  const CardSecundaryWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(15),
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
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 229, 255, 230),
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: const SmallText(title: "Credit"),
            ),
          ),
          Positioned(
            top: size.height * 0.05,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height:  MediaQuery.of(context).size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(title: title,size: 25,),
                  const Spacer(),
                  const SmallText(title: "Lesson",color: Colors.black54,),
                  const SizedBox(height: 10,),
                  Container(
                    width: 50,
                    height: 2,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 20,
              width: 100,
              child: const Row(
                children: [
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
          const Positioned(
            bottom: 0,
            right: 0,
            child: ButtonCardWidget(),
          ),
        ],
      ),
    );
  }
}