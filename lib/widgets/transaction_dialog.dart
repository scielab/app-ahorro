import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/calculator_widget.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class TransactionDialog extends StatelessWidget {
  const TransactionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 620,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 160, 212, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on_sharp,size: 25,),
                        SizedBox(width: 10,),
                        SmallText(title: "Cash"),
                        Spacer(),
                        Icon(Icons.arrow_drop_down_outlined,size: 20,),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 159, 255, 182),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_basket,size: 25,),
                        SizedBox(width: 10,),
                        SmallText(title: "Cash"),
                        Spacer(),
                        Icon(Icons.arrow_drop_down_outlined,size: 20,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            const SmallText(title: "Expenses"),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "\$",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const BigText(title: "25.00",size: 42,)
              ],
            ),
            const SizedBox(height: 20,),
            const SmallText(title: "add comment"),
            const Spacer(),
            CalculatorWidget(),
          ],
        ),
      ),
    );
  }
}
