import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/bottomNavigatorBar.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/button_base_drop.dart';
import 'package:app/widgets/floating_button_custom.dart';
import 'package:app/widgets/shopping_item.dart';
import 'package:app/widgets/small_text.dart';
import 'package:app/widgets/transaction_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Center(child: BigText(title: "Total balance")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ButtonBase(
                          title: "Expenses",
                          primary: true,
                        ),
                        ButtonBase(title: "Income"),
                        ButtonBaseDrop(title: "June"),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SmallText(title: "Recent"),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: const Column(
                        children: [
                          ShoppingItem(
                              title: "Shopping",
                              category: "Cash",
                              value: "498.50",
                              porcent: "32%",
                              icon: Icons.shopping_basket,
                              colorIcon: Colors.green),
                          ShoppingItem(
                              title: "Gifts",
                              category: "Cash",
                              value: "498.50",
                              porcent: "21%",
                              icon: Icons.card_giftcard_rounded,
                              colorIcon: Colors.pink),
                          ShoppingItem(
                              title: "Food",
                              category: "Cash",
                              value: "498.50",
                              porcent: "12%",
                              icon: Icons.food_bank,
                              colorIcon: Colors.orange),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ButtonNavigatorBarPrimary(),
            ),
            */
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonCustom(110,200),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            onPressed: () {
              showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: "Dialog calculator",
                transitionBuilder:
                    (context, animation, secundaryAnimation, child) {
                  Tween<Offset> tween;
                  tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
                  return SlideTransition(
                    position: tween.animate(CurvedAnimation(
                        parent: animation, curve: Curves.easeInOut)),
                    child: child,
                  );
                },
                context: context,
                pageBuilder: (context, _, __) => const Align(
                    alignment: Alignment.bottomCenter,
                    child: TransactionDialog()),
              );
            },
            child: const Icon(Icons.add,color: Colors.white,size: 42),
          ),
      ),
      bottomNavigationBar: ButtonNavigatorBarPrimary(),
    );
  }
}
