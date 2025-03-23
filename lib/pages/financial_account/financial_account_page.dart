import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/financial_accounts/financial_account_controller.dart';
import 'package:app/models/financial_account_model.dart';
import 'package:app/pages/financial_account/financial_account_add.dart';
import 'package:app/pages/financial_account/financial_account_detail_page.dart';
import 'package:app/utils/color_custom.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/common/tag/tag_default_empty_widget.dart';
import 'package:app/widgets/common/tag/tag_item_account_budget_widget.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/floating_button_custom.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialAccountPage extends StatefulWidget {
  const FinancialAccountPage({super.key});

  @override
  State<FinancialAccountPage> createState() => _FinancialAccountPageState();
}

class _FinancialAccountPageState extends State<FinancialAccountPage> {
  bool light = true;
  late String userid = Get.find<AuthController>().getCurrentUser()!.uid;

  FinancialAccountController financialAccountController = Get.find<FinancialAccountController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


    // Colores de Grafico:
    List<Map<String,dynamic>> colorsTypeAccount = [
      {
        'color': 'green',
      }
    ];



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Saldo"),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => FinancialAccountAddPage(userid: userid,));
            },
            child: const SmallText(title: "+ Agregar cuenta")
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20,),   
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              child: FutureBuilder(
                  future: financialAccountController.getBudgetAccountByUserId(userid),
                  initialData: null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.contentColorBlue,));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      
                      // traer las analiticas aqui de porcentaje
                      var financialBudgetAccount = snapshot.data;

                      // Este es un problema de codigo no puedo resolver correctamente
                      // if (financialBudgetAccount != null) {
                      //   financialBudgetAccount.getPorcentFinancialBudgetAccount("Cash", financialBudgetAccount);
                      // }

                      return PieChart(PieChartData(
                          centerSpaceRadius: 30,
                          sectionsSpace: 10,
                          sections: List.generate(
                            financialBudgetAccount!.length,
                            (index) {
                              return PieChartSectionData(
                                value: 10,
                                showTitle: true,
                                radius: 70,
                                titleStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimension.font20,
                                    fontWeight: FontWeight.bold),
                                color: Colors.green,
                              );
                            },
                          )));
                    } else {
                      return Container();
                    }
                  }),
            ),
            const SizedBox(height: 40,),
            const BigText(title: "Mis Cuentas"),
            const SizedBox(height: 20,),
            FutureBuilder(
              future: financialAccountController.getBudgetAccountByUserId(userid), 
              builder: (context, snapshot ){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
            
                  final data = snapshot.data;
                  if(data != null && data.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                          
                          final BudgetAccountModel budgetAccountModel = snapshot.data![index];
                          // return TagItemGoalWidget(onPress: () {
                          //   Get.to(GoalsDetailPage(goalsModel: goalsModelCurrent));
                          // }, goalsModel: goalsModelCurrent,);
                          return TagItemAccountBudgetWidget(title: "Supermercado", category: "Ingreso", value: "10000", porcent: "1", icon: Icons.card_giftcard_rounded, colorIcon: Colors.green,onPress: () {
                            Get.to(() => FinancialAccountDetailPage(budgetAccountModel: budgetAccountModel));
                          });
                        }),
                      );
                  
                  } else {
                    return Center(
                      child: TagDefaultEmptyWidget(image: 'assets/svg/svg1.svg',textPrincipal: "Tocar para Crear",textSecondary: "Sin objetivos establecidos",onPress: () {
                        Get.to(() => FinancialAccountAddPage(userid: userid));
                      },),
                    );
                  }                
                }
                return Center(
                  child: TagDefaultEmptyWidget(image: 'assets/svg/svg1.svg',textPrincipal: "Tocar para Crear",textSecondary: "Sin objetivos establecidos",onPress: () {
                    Get.to(() => FinancialAccountAddPage(userid: userid));
                  },),
                );
              }
            ),
          ],

        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonCustom(size.height * 0.14, size.width * 0.7),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          // navegar a la pagina de detail
          Get.to(() => FinancialAccountAddPage(userid: userid));
        }),
    );
    
  }
}