import 'package:app/utils/color_custom.dart';
import 'package:flutter/material.dart';

List<Widget> bottomNavs = const [
  Icon(
      Icons.home,
      color: Colors.white,
    ),
  Icon(
      Icons.search,
      color: Colors.white,
    ),
  Icon(
      Icons.analytics,
      color: Colors.white,
    ),
  Icon(
      Icons.self_improvement_outlined,
      color: Colors.white,
    ),
];

class ButtonNavigatorBarPrimary extends StatelessWidget {
  const ButtonNavigatorBarPrimary({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
              color: AppColors.mainColor.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(bottomNavs.length, (index) => GestureDetector(
                onTap: () {},
                child:   SizedBox(
                  width: 36,
                  height: 36,
                  child: bottomNavs[index],
              )),
              ),
            ],
          ),
        ),
      );
  
  }
}
