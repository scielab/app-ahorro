import 'package:app/controllers/budget/budget_item_controller.dart';
import 'package:app/models/categories_models.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPayPage extends StatefulWidget {
  const CategoryPayPage({super.key});

  @override
  State<CategoryPayPage> createState() => _CategoryPayPageState();
}

class _CategoryPayPageState extends State<CategoryPayPage> {
  var current_index = 0;
  BudgetItemController budgetItem = Get.find<BudgetItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(title: "Categoria"),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.blue[200]),
            margin: const EdgeInsets.only(right: 30),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(pay.length, (index) {
            return GestureDetector(
              onTap: () {
                // Seleccionamos el icon que tenemos
                current_index = index;
                // volvemos a la pagina de creacion de transaccion
                setState(() {              
                  print(budgetItem.category.value);
                  budgetItem.udateCategory(index);
                });
                Get.back();
              },
              child: Container(
                child: Column(
                  children: [
                    Icon(
                      pay[index]['icon'],
                      size: 42,
                    ),
                    Center(
                        child: SmallText(
                      title: pay[index]['name'],
                      size: 18,
                    )),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
