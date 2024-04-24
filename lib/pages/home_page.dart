import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/models/categories_models.dart';
import 'package:app/models/progress_model.dart';
import 'package:app/models/transaction_model.dart';
import 'package:app/pages/budget/budget_detail_page.dart';
import 'package:app/pages/progress/progress.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/date_format.dart';
import 'package:app/utils/generate.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/button_base_drop.dart';
import 'package:app/widgets/floating_button_custom.dart';
import 'package:app/widgets/shopping_item.dart';
import 'package:app/widgets/transaction_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

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
  final dateController = TextEditingController();
  var _currentStartDate;
  String typeQuery = 'income';


  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    if (selectedDate != null) {
      setState(() {
        _currentStartDate = selectedDate;
        dateController.text = selectedDate != null
            ? convertCompleteTimeToDate(selectedDate.toString())
            : "";
      });
    }
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        });
  }

  bool loaderScreen = false;
  @override
  void initState() {
    //var budget = Get.find<BudgetController>().getBudgetRecentToFirebase;
    //budget.getBudgetRecentToFirebase();
    Future.delayed(const Duration(seconds: 1), () {
      loaderScreen = true;
      setState(() {
        
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var anim = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 500),
    );
    return loaderScreen ? Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Total Balance")),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProgressPage());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.analytics,size: 32,)),
          ),
        ],
      ),
      body:  Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            typeQuery = types[1];
                          });
                        },
                        child: const ButtonBase(
                          title: "Expenses",
                          primary: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            typeQuery = types[0];
                          });
                        },
                        child: const ButtonBase(title: "Income")
                      ),
                      GestureDetector(
                          onTap: () {
                            callDatePicker();
                          },
                          child: const ButtonBaseDrop(title: "June")),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                    child: FutureBuilder(
                        future: Get.find<BudgetController>().getBudgetRecentToFirebase(typeQuery),
                        initialData: null,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List<TransactionBase> transactions = Get.find<BudgetController>().transactions;
                            return Container(
                              margin: const EdgeInsets.only(left: 20, right: 20),
                              child: ListView.builder(
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> category_data = transactions[index].type == 'income' ? 
                                        searchIcon(
                                            transactions[index].category, pay) : searchIcon(transactions[index].category, expense);
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => const BudgetDetailPage());
                                      },
                                      child: ShoppingItem(
                                          title: transactions[index].title,
                                          category:
                                              category_data['name'] as String,
                                          value: transactions[index]
                                              .amount
                                              .toString(),
                                          porcent: "32%",
                                          icon: category_data['icon'] as IconData,
                                          colorIcon: category_data['color']),
                                    );
                                  }),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        
      ),
      floatingActionButtonLocation: FloatingActionButtonCustom(110, 220),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        activeIcon: Icons.close,
        spacing: 8,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 20,
        animationCurve: Curves.elasticInOut,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Ingreso',
            onTap: () {
              showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: "Dialog calculator",
                transitionDuration: const Duration(milliseconds: 500),
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
                    child: TransactionDialog(
                      type_account: 'income',
                    )),
              );
            },
            onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: const Icon(Icons.brush),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'Gasto',
            onTap: () {
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
                    child: TransactionDialog(
                      type_account: 'expense',
                    )),
              );
            },
          ),
        ],
      ),
    ) : const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
