import 'package:app/routes/routes.dart';
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
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

enum _SelectedTab { home, search, analytics, self_improvement_outlined }

List<String> routes = [
  RouterHelper.getHomePage(),
  RouterHelper.getGuildPage(),
  RouterHelper.getProgressPage(),
  RouterHelper.getSettingsPage()
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var anim = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 500),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
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
      ),
      floatingActionButtonLocation: FloatingActionButtonCustom(110, 220),
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
          child: const Icon(Icons.add, color: Colors.white, size: 42),
        ),
      ),
      //bottomNavigationBar: ButtonNavigatorBarPrimary(),

      /*
      bottomNavigationBar: Container(
        height: 130,
        child: DotNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: _SelectedTab.values.indexOf(_selectedTab),
            dotIndicatorColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            splashBorderRadius: 50,
            // enableFloatingNavBar: false,
            onTap: _handleIndexChanged,
            items: [
         
              DotNavigationBarItem(
                icon: const Icon(Icons.home),
                selectedColor: Colors.white,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.search),
                selectedColor: Colors.white,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.analytics),
                selectedColor: Colors.white,
              ),
              DotNavigationBarItem(
                icon: const Icon(Icons.self_improvement_outlined),
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
        */
    );
  }
}
