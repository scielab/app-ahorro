
import 'package:app/models/transaction_model.dart';

class BudgetModel {
  double income;
  double expenses;
  double balance;
  List<Transaction> transactions; // Lista de transacciones

  BudgetModel({
    required this.income,
    required this.expenses,
    required this.balance,
    required this.transactions,
  });
}