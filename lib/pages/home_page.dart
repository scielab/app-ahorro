import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/models/categories_models.dart';
import 'package:app/models/progress_model.dart';
import 'package:app/models/transaction_model.dart';
import 'package:app/pages/budget/budget_detail_page.dart';
import 'package:app/pages/progress/progress.dart';
import 'package:app/utils/date_format.dart';
import 'package:app/utils/generate.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/button_base_drop.dart';
import 'package:app/widgets/floating_button_custom.dart';
import 'package:app/widgets/shopping_item.dart';
import 'package:app/widgets/transaction_dialog.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  final budgetController = Get.find<BudgetController>();
  bool searchByDate = false;
  final dateController = TextEditingController();
  var _currentStartDate = DateTime.now();
  String typeQuery = 'income';

  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    if (selectedDate != null) {
      setState(() {
        _currentStartDate = selectedDate;
        searchByDate = true;
        dateController.text = convertCompleteTimeToDate(selectedDate.toString());
      });
      // hacer una consulta con la fecha especifica 
      
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
    Future.delayed(const Duration(seconds: 1), () {
      loaderScreen = true;
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                            searchByDate = false;
                          });
                        },
                        child: const ButtonBase(
                          title: "Gasto",
                          primary: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            typeQuery = types[0];
                            searchByDate = false;
                          });
                        },
                        child: const ButtonBase(title: "Ingreso")
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
                        future: searchByDate ? budgetController.getBudgetFilterbyDateToFirebase(_currentStartDate,typeQuery) : budgetController.getBudgetRecentToFirebase(typeQuery),
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
                                    Map<String, dynamic> categoryData = transactions[index].type == 'income' ? 
                                        searchIcon(
                                            transactions[index].category, pay) : searchIcon(transactions[index].category, expense);
                                    return transactions.isNotEmpty ? GestureDetector(
                                      onTap: () {
                                        Get.to(() => BudgetDetailPage(uid: transactions[index].id.toString(), tb: transactions[index],));
                                      },
                                      child: ShoppingItem(
                                          title: categoryData['name'] as String,
                                          category: transactions[index].title,
                                          value: transactions[index].amount.toString(),
                                          porcent: convertCompleteTimeToDate(transactions[index].date.toString()),
                                          icon: categoryData['icon'] as IconData,
                                          colorIcon: categoryData['color']),
                                    ) : const Center(
                                      child: BigText(title: "No tienes transacciones registradas",over: true),
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
      floatingActionButtonLocation: FloatingActionButtonCustom(size.height * 0.14, size.width * 0.56),
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
