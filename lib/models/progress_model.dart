
import 'package:app/models/category_model.dart';
import 'package:app/models/transaction_model.dart';

class Progress {

}
class Report {

}
/*
Report:
- cantidad
- tipo

AnaliticiItem:
- categoty (Color, y icono)
- Porcentaje
- transaction base
*/

class AnalyticItem {
  Category category;
  double totalPorcent;
  int totalAmmount;
  AnalyticItem({
    required this.category,
    required this.totalPorcent,
    required this.totalAmmount,
  });

}

  List<String> types = [
    "income",
    "expense"
  ];