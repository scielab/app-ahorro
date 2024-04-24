import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';


class CardPrimeryWidget extends StatelessWidget {
  final String title;

  const CardPrimeryWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Row(
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
          BigText(
            title: title,
            size: 22,
          ),
          const SmallText(
            title: "5 min lectura",
            color: Colors.black54,
          ),
          const Row(
            children: [
              Spacer(),
              ButtonCardWidget(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 2,
                color: Colors.black,
              ),
            ],
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
      width: 45,
      height: 45,
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
