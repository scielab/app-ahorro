import 'package:app/models/transaction_model.dart';
import 'package:get/get.dart';

// Gestiona la informacion de una nueva Transaccion
class BudgetItemController extends GetxService {
  var id = '2'.obs;
  var title = ''.obs;
  var amount = 0.obs;
  var date = DateTime.now().obs;
  var type = ''.obs;
  var userid = ''.obs;
  var category = 1.obs;

  TransactionBase buildTransaction() {
    return TransactionBase(
      id: id.value,
      title: title.value,
      amount: amount.value,
      date: date.value,
      type: type.value,
      userid: userid.value,
      category: category.value,
    );
  }

 void displayInfo() {
    print('ID: ${id.value}');
    print('Title: ${title.value}');
    print('Amount: ${amount.value}');
    print('Date: ${date.value}');
    print('Type: ${type.value}');
    print('UserID: ${userid.value}');
    print('Category: ${category.value}');
  }

  bool validate() {
    if(title.isEmpty && type.value == 'income') {
      title.value = 'Income';
    } else if(title.isEmpty && type.value == 'expense') {
      title.value = 'Expense';
    }
    return id.value.isNotEmpty &&
        title.value.isNotEmpty &&
        amount.value > 0 &&
        type.value.isNotEmpty &&
        userid.value.isNotEmpty &&
        category.value > 0;
  }

  void udateCategory(int index) {
    category.value = index;
  }

  void updateType(String op) {
    type.value = op;
  }
  void updateAmount(int num) {
    amount.value = num;
  }
  void updateUserId(String uid) {
    userid.value = uid;
  }
}