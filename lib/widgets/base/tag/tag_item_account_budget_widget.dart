import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/material.dart';

class TagItemAccountBudgetWidget extends StatelessWidget {
  final String title;
  final String category;
  final String value;
  final String porcent;
  final IconData icon;
  final Color colorIcon;
  final VoidCallback? onPress;

  const TagItemAccountBudgetWidget({
    super.key,
    required this.title,
    required this.category,
    required this.value,
    required this.porcent,
    required this.icon,
    required this.colorIcon,
    this.onPress
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if(onPress != null) {
          onPress!();
        }
      },
      child: Container(
        width: size.width,
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
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  child: BigText(title: title,size: Dimension.font18,),
                ),
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
                    BigText(title: value,size: Dimension.font16,),
                  ],
                ),
                SmallText(
                  title: porcent,
                  color: Colors.grey[500] as Color,
                  size: Dimension.font16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
