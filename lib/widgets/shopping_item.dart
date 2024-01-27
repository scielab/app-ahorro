import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ShoppingItem extends StatelessWidget {
  final String title;
  final String category;
  final String value;
  final String porcent;
  final IconData icon;
  final Color colorIcon;

  const ShoppingItem(
      {super.key,
      required this.title,
      required this.category,
      required this.value,
      required this.porcent,
      required this.icon,
      required this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipOval(
            child: Material(
              color: colorIcon,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(title: title),
              SmallText(
                title: category,
                color: Colors.grey[500] as Color,
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '\$',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                  BigText(title: value),
                ],
              ),
              SmallText(
                title: porcent,
                color: Colors.grey[500] as Color,
              )
            ],
          ),
        ],
      ),
    );
  }
}
