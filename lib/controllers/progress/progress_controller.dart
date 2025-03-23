import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/models/data/categories_models.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/analytics_model.dart';
import 'package:app/models/transaction_model.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  RxList<Category> allCategories = <Category>[].obs;
  RxList<TransactionBase> transactions = <TransactionBase>[].obs;
  RxList<AnalyticItem> analytics = <AnalyticItem>[].obs;


  @override
  onInit() async {
    transactions.value = await Get.find<BudgetController>().getBudgetFilterMonthData();
    getReport("income");
    /*
    once(transactions, (callback) async {
      print("hola2");
    });
    */
    super.onInit();
  }

  Future<void> getBudget(String type) async {
    transactions.value = await Get.find<BudgetController>().getBudgetFilterMonthData();
    getReport(type);
  }

  // Obtiene las categorias  guardadas a un array
  void getCategory(String type) {
    Set<String> categoryIds = Set();
    allCategories.clear();

    for (var tr in transactions) {
      if (tr.type == type) {
        Map<String, dynamic> data = {};
        if (type == 'income') {
          data = pay.firstWhere((element) => element['id'] == tr.category);
        } else if (type == 'expense') {
          data = expense.firstWhere((element) => element['id'] == tr.category);
        }
        String categoryId = data['id'].toString(); 
        if (!categoryIds.contains(categoryId)) {
          Category category = Category(
            id: tr.id.toString(),
            category: tr.category,
            name: data['name'],
            icon: data['icon'],
            color: data['color']
          );
          allCategories.add(category);
          categoryIds.add(categoryId); 
        }
      }
    }
  }

  // Obtner la cantidad diaria de Ingreso o de Gasto
  String getTotalAmmountDay(String type) {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateTime endDate = startDate.add(const Duration(days: 1));
    int totalAmount = transactions
      .where((tr) => tr.type == type && tr.date.isAfter(startDate) && tr.date.isBefore(endDate))
      .fold(0, (previous, current) => previous + current.amount.toInt());
    return totalAmount.toString();
  }
  // Obtener la cantidad semanal de ngreso o de Gasto
  String getTotalAmmountWeek(String type) {
    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(Duration(days: currentDate.weekday + 6));
    DateTime endDate = currentDate.subtract(Duration(days: currentDate.weekday));

    int totalAmount = transactions
      .where((tr) => tr.type == type && tr.date.isAfter(startDate) && tr.date.isBefore(endDate))
      .fold(0, (previous, current) => previous + current.amount.toInt());
    return totalAmount.toString();
  }
  // Obtener la cantidad mensual de Ingreso o de Gasto
  String getTotalAmmountMonh(String type) {
    int totalAmount = transactions
        .where((tr) => tr.type == type)
        .fold(0, (previous, current) => previous + current.amount.toInt());
    return totalAmount.toString();
  }

  dynamic getAllAmmount() {
    var income = getTotalAmmountMonh('income');
    var expense = getTotalAmmountMonh('expense');

    if(detectNumberType(income) == NumberType.integer && detectNumberType(expense) == NumberType.integer) {
      int incomeRes = int.parse(income);
      int expenseRes = int.parse(expense);
      var saving = incomeRes - expenseRes;
      return saving;
    } else if(detectNumberType(expense) == NumberType.double && detectNumberType(expense) == NumberType.double) {
      double incomeRes = double.parse(income);
      double expenseRes = double.parse(expense);
      var saving = incomeRes - expenseRes;
      return saving;
    } else {
      return 0;
    }
  }


  // porcent of the total income or expense
  // calcular el porcentaje del mes de una categoria en especifico
  void getPorcent(String type) {
    analytics.clear();
    double totalAmount = transactions
        .where((tr) => tr.type == type)
        .fold(0, (previous, current) => previous + current.amount);
    
    for (var category in allCategories) {
      int categoryAmount = transactions
          .where((tr) => tr.type == type && tr.category == category.category)
          .fold(0, (previous, current) => previous + current.amount);
      if(categoryAmount != 0) {
        int totalamountItem = categoryAmount;
        double categoryPercent = ((categoryAmount / totalAmount) * 100).roundToDouble();
        analytics.add(
          AnalyticItem(
            category: category,
            totalPorcent: categoryPercent,
            totalAmmount: totalamountItem,
          ),
        );
      }
    }
  }

  // Get Expense, Income, Saving



  // Report, day, week, month
  // generar un reporte completo de todas las categorias con sus porcentajes
  void getReport(String type) {
    getCategory(type);
    getPorcent(type);
    analytics.forEach((item) {
      print("Categoría: ${item.category.name},  Porcentaje: ${item.totalPorcent}%");
    });

  }}
