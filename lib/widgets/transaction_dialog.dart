import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/controllers/budget/budget_item_controller.dart';
import 'package:app/models/categories_models.dart';
import 'package:app/models/transaction_model.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/date_format.dart';
import 'package:app/widgets/calculator_widget.dart';
import 'package:app/widgets/input_field.dart';
import 'package:app/widgets/small_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionDialog extends StatefulWidget {
  final String type_account;
  const TransactionDialog({super.key, required this.type_account});
  
  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  var _currentStartDate;
  final dateController = TextEditingController();
  final commentController = TextEditingController();

  BudgetItemController budgetItem = Get.find<BudgetItemController>();
  BudgetController _budgetController = Get.find<BudgetController>();
  late User user;
  
  @override
  void initState()  {
    budgetItem.updateType(widget.type_account);
    user = Get.find<AuthController>().getCurrentUser()!;
    super.initState();
  }

  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    if(selectedDate != null ) {
      setState(() {
        _currentStartDate = selectedDate;
        dateController.text = selectedDate != null ? convertCompleteTimeToDate(selectedDate.toString()) : "";
      });
    }
  }

  Future<DateTime?> getDatePickerWidget() {
    return showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
      builder: (context,child) {
        return Theme(data: ThemeData.dark(),child: child!);
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    TextEditingController value = TextEditingController();

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 620,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.type_account == 'income') {
                      Get.toNamed(RouterHelper.getCategoryAccountPayPage());
                    } else {
                      Get.toNamed(RouterHelper.getCategoryAccountPage());
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 160, 212, 255),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => Icon(get_icon(widget.type_account,budgetItem),
                                size: 25,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(
                            () => SmallText(
                              title: get_category(widget.type_account, budgetItem),
                              size: 12,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    callDatePicker();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 159, 255, 182),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.date_range_rounded,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SmallText(
                            title: dateController.text.isNotEmpty ? dateController.text : "Date",
                            size: 10,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SmallText(title: "Expenses"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$",
                  style: TextStyle(
                      color: Colors.grey[500],
                      decoration: TextDecoration.none,
                      fontSize: 20),
                ),
                //const BigText(title: "25.00",size: 42,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Material(
                    child: InputField(
                      controller: value,
                      labelText: "25.00",
                      isTransparent: false,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SmallText(title: "add comment"),
            const Spacer(),
            CalculatorWidget(valueController: value,onPressed: () {
              createTransaction(budgetItem,_budgetController,value,user);
              Get.toNamed(RouterHelper.getHomePage());
            },),
          ],
        ),
      ),
    );
  }

    String get_category(String op,BudgetItemController controller) {
      if(op == 'income') {
        return controller.category.value != 0 ? pay[controller.category.value]['name'] : 'Cash';
      } else {
        return controller.category.value != 0 ? expense[controller.category.value]['name'] : 'Shopping';
      }
    }
    IconData get_icon(String op,BudgetItemController controller) {
      if(op == 'income') {
        return controller.category.value != 0 ? pay [controller.category.value]['icon'] : Icons.monetization_on_sharp;
      } else {
        return controller.category.value != 0 ? expense[controller.category.value]['icon'] : Icons.shopping_basket;
      }
    }
    // Bug hay que presionar 2 veces el boton para que funcione
    void createTransaction(BudgetItemController budgetItemController, BudgetController budgetController,TextEditingController value, User user) {
      print(budgetItemController.validate());
      budgetItemController.displayInfo();
      int amount = int.parse(value.text);
      budgetItemController.updateAmount(amount);
      budgetItemController.updateUserId(user.uid);
      if(budgetItemController.validate()) {
        TransactionBase new_tran = budgetItemController.buildTransaction(); 
        budgetController.addBudgetToFirebase(new_tran);
      }
    }
}
