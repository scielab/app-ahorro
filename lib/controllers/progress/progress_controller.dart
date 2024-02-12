import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/models/categories_models.dart';
import 'package:app/models/category_model.dart';
import 'package:app/models/progress_model.dart';
import 'package:app/models/transaction_model.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  RxList<Category> allCategories = <Category>[].obs;
  RxList<TransactionBase> transactions = <TransactionBase>[].obs;
  RxList<AnalyticItem> analytics = <AnalyticItem>[].obs;

  @override
  onInit() async {
    transactions.value = await Get.find<BudgetController>().getBudgetFilterMonthData();
    getReport("income");
    once(transactions, (callback) async {
      print("hola");
    });
    super.onInit();
  }

  Future<void> getBudget() async {
    transactions.value = await Get.find<BudgetController>().getBudgetFilterMonthData();
    //getReport("income");
  }

  // Primero reporte del mes
  // category use in the report
  // Verificar y agregar las categorias existentes en el mes
  /*
  void getCategory(String type) {
    allCategories.clear();
    for (var tr in transactions) {
      if (tr.type == type) {
        var data = Map<String, dynamic>();
        if (type == 'income') {
          data = pay[tr.category];
        } else if (type == 'expense') {
          data = expense[tr.category];
        }
        Category category = Category(
            id: data['id'],
            name: data['name'],
            icon: data['icon'],
            color: data['color']);
        if (!allCategories.contains(category)) {
          allCategories.add(category);
        }
      }
    }
  }
  */

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

  String getTotalAmmountDay(String type) {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateTime endDate = startDate.add(const Duration(days: 1));
    int totalAmount = transactions
      .where((tr) => tr.type == type && tr.date.isAfter(startDate) && tr.date.isBefore(endDate))
      .fold(0, (previous, current) => previous + current.amount.toInt());
    return totalAmount.toString();
  }
  String getTotalAmmountWeek(String type) {
    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(Duration(days: currentDate.weekday + 6));
    DateTime endDate = currentDate.subtract(Duration(days: currentDate.weekday));



    int totalAmount = transactions
      .where((tr) => tr.type == type && tr.date.isAfter(startDate) && tr.date.isBefore(endDate))
      .fold(0, (previous, current) => previous + current.amount.toInt());
    return totalAmount.toString();
  }
  String getTotalAmmountMonh(String type) {
    int totalAmount = transactions
        .where((tr) => tr.type == type)
        .fold(0, (previous, current) => previous + current.amount.toInt());
    return totalAmount.toString();
  }

  // porcent of the total income or expense
  // calcular el porcentaje del mes de una categoria en especifico
  void getPorcent(String type) {
    analytics.clear();
    double totalAmount = transactions
        .where((tr) => tr.type == type)
        .fold(0, (previous, current) => previous + current.amount);

    for (var category in allCategories) {
      print("MOstrando info");
      print(category.category);
      print("termino info");
      int categoryAmount = transactions
          .where((tr) => tr.type == type && tr.category == category.category)
          .fold(0, (previous, current) => previous + current.amount);
      if(categoryAmount != 0) {
        int totalamountItem = categoryAmount;
        double categoryPercent = (categoryAmount / totalAmount) * 100;
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

  // Report, day, week, month
  // generar un reporte completo de todas las categorias con sus porcentajes
  void getReport(String type) {
    getCategory(type);
    print(allCategories.length);
    for (var cat in allCategories) {
      print(cat.name);
    }
    getPorcent(type);
    analytics.forEach((item) {
      print("Categoría: ${item.category.name},  Porcentaje: ${item.totalPorcent}%");
    });
  }}
