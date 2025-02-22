import 'package:app/controllers/financial_accounts/financial_account_controller.dart';
import 'package:app/models/financial_account_model.dart';
import 'package:app/pages/financial_account/financial_account_add.dart';
import 'package:app/widgets/base/button/button_base_widget.dart';
import 'package:app/widgets/base/tag/tag_item_account_budget_widget.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialAccountDetailPage extends StatefulWidget {  

  final BudgetAccountModel budgetAccountModel;
  const FinancialAccountDetailPage({super.key, required this.budgetAccountModel}); 


  @override
  State<FinancialAccountDetailPage> createState() => _FinancialAccountDetailPageState();
}

class _FinancialAccountDetailPageState extends State<FinancialAccountDetailPage> {

  final FinancialAccountController financialAccountController = Get.find<FinancialAccountController>();



  Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode('56');
  bool light = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController notasController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Principal"),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(FinancialAccountAddPage(userid: widget.budgetAccountModel.id!, isUpdateInfo: widget.budgetAccountModel,isUpdate: true,));
            },
            child: const SmallText(title: "Editar"),
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),

            // relenar los demas campos
            TagItemAccountBudgetWidget(title: widget.budgetAccountModel.name, category: "Ingreso", value: widget.budgetAccountModel.ammount.toString(), porcent: "1", icon: Icons.card_giftcard_rounded, colorIcon: Colors.green),

            const SmallText(title: "Transacciones"),


            const Spacer(),
            ButtonBaseWidget(title: "Aceptar", onPress: () {
              Get.back();
            }),
            const SizedBox(height: 10,),

            ButtonBaseWidget(title: "Eliminar", onPress: () {
              if(widget.budgetAccountModel.id != null) {
                financialAccountController.deleteBudgetAccountToFirebase(widget.budgetAccountModel.id!);
                Get.back();
              }
            }, colorBack: Colors.white, colorText: Colors.black,),
            const SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }

  void _openFilteredCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: const EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: const InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: const Text('Selecciona el tipo de divisa'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedFilteredDialogCountry = country),
                itemBuilder: _buildDialogItem)),
  );

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text(
            '${country.currencyCode}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name ?? ''))
        ],
      );


}