
import 'package:app/models/category_model.dart';



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