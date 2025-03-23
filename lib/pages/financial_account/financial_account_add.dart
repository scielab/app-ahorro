

import 'package:app/controllers/financial_accounts/financial_account_controller.dart';
import 'package:app/models/financial_account_model.dart';
import 'package:app/widgets/common/button/button_base_widget.dart';
import 'package:app/widgets/common/selected/category_selected.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/input/input_field.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinancialAccountAddPage extends StatefulWidget {
  final bool isUpdate;
  final String userid;
  final BudgetAccountModel? isUpdateInfo;

  const FinancialAccountAddPage({super.key,required this.userid,this.isUpdate = false, this.isUpdateInfo});

  @override
  State<FinancialAccountAddPage> createState() => _FinancialAccountAddPageState();
}

class _FinancialAccountAddPageState extends State<FinancialAccountAddPage> {

  // argumento para indicar si esto es update o add
  late FinancialAccountController budgetAccountController;

  @override
  void initState() {
    super.initState();
    budgetAccountController = Get.find<FinancialAccountController>(); // nota debe ser registrado en dependencias
    if(widget.isUpdate && widget.isUpdateInfo != null) {
      // asignamos todos los tipos de datos aqui
      nameController.text = widget.isUpdateInfo!.name;
      notesController.text = widget.isUpdateInfo!.notes;
      ammountController.text = widget.isUpdateInfo!.ammount.toString();

      final selectedIcon = icons.firstWhere((icon) => icon["id"] == int.parse(widget.isUpdateInfo!.accountType));
      typeAccountController.text = selectedIcon['title'];
      _selectedTypeAccountId = selectedIcon['id'];

    }
  }

  Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode('56');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController ammountController = TextEditingController();
  final TextEditingController typeAccountController = TextEditingController(); // type of account
  final TextEditingController totalAmmountController = TextEditingController();


  //CategorySelectedWidget
  final categoryCreditCard = [
    {
      'id': 1,
      'label': 'Master Card',
      'icon': Icons.card_giftcard,
    }
  ];
  String _selectedTypeAccount = '';
  int _selectedTypeAccountId = 0;


  bool light = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Agregar cuenta nueva"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height * 0.85,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const SmallText(title: "Nombre"),
                  InputField(controller: nameController, labelText: "Nombre",enable: true),
                  const SizedBox(height: 20,),
                  const SmallText(title: "Cantidad"),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(controller: ammountController, labelText: "Cantidad",enable: true,isNumeric: true),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.5,
                        child: ListTile(
                          onTap: _openFilteredCountryPickerDialog,
                          title: _buildDialogItem(_selectedFilteredDialogCountry),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const SmallText(title: "Tipo de Cuenta"),
                  InputField(controller: typeAccountController, labelText: "Nombre",enable: true),
                
                  const SizedBox(height: 20,),
                  const SmallText(title: "Notas"),
                  InputField(controller: notesController, labelText: "Notas",enable: true),

                  const SizedBox(height: 20,),
                  ButtonBaseWidget(title: _selectedTypeAccount.isNotEmpty ? _selectedTypeAccount : "Icon", onPress: () {
                      _dialogBuilder(context);
                      
                      // Get.to(() =>
                      //   CategorySelectedWidget(categories: categoryCreditCard, onCategorySelected: (selectedCategory) {
                      //     _selectedCategory = selectedCategory;
                      //     setState(() {
                            
                      //     });
                      //   }),
                      // );

                    }),
                
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SmallText(title: "Incluir en el saldo total"),
                      const Spacer(),
                      Switch(
                        value: light,
                        activeColor: Colors.red,
                        onChanged: (bool value) {
                          setState(() {
                            light = value;
                          });
                        },
                      )
                    ],
                  ),


                  const SizedBox(height: 20,),
                  const SmallText(title: "Cantidad Acumulada"),
                  AnimatedOpacity(
                    opacity: light ? 1 : 0, 
                    duration: const Duration(milliseconds: 300),
                    child: InputField(controller: totalAmmountController, labelText: "Cantidad Aumulada",enable: true,isNumeric: true),
                  ),


                  const Spacer(),
                  ButtonBaseWidget(title: widget.isUpdate ? "Update" : "Agregar", onPress: () {
                    if(widget.isUpdate) {
                      updateGoalToController();
                    } else {
                      addGoalsToController();
                      Get.back();
                    }
                  }),
                  const SizedBox(height: 10,),
                        
                  ButtonBaseWidget(title: "Cancelar", onPress: () {
                    Get.back();
                  }, colorBack: Colors.white, colorText: Colors.black,),
                        
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String,dynamic>> icons = [
    {
      "id": 1,
      "icon": "assets/icons/visa.png",
      "title": "Master Card" 
    },
    {
      "id": 2,
      "icon": "assets/icons/masterCard.png",
      "title": "Visa"
    }
  ];


  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5.0,
          backgroundColor: Colors.white,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const BigText(title: "Seleccion el tipo de tarjeta"),
                const SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                    itemCount: icons.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _selectedTypeAccount = icons[index]['title'];
                          _selectedTypeAccountId = icons[index]['id'];
                          typeAccountController.text = _selectedTypeAccount;
                          setState(() {
                          });
                          Get.back();
                        },
                        child: SizedBox(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(icons[index]['icon']),
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              const SizedBox(width: 10),
                              SmallText(title: icons[index]['title']),
                            ],
                          ),
                        ),
                      );
                  }),
                ),
                const Spacer(),
                ButtonBaseWidget(title: "Cancelar", onPress: () {
                  Get.back();
                })                
              ],
            )
          ),
        );
      }
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



  // Estas son funciones que conectan con el controller
  void addGoalsToController() {
    if(nameController.text.isEmpty || notesController.text.isEmpty || ammountController.text.isEmpty) {
      // No esta funcionanod el Snackbar
      Get.snackbar('Error', 'tiene campos vacios');
    } else {
      BudgetAccountModel budgetAccountModel = BudgetAccountModel(
        userid: widget.userid,
        name: nameController.text, 
        notes: notesController.text, 
        ammount: int.parse(ammountController.text),
        accountType: _selectedTypeAccountId.toString(),
      );
      budgetAccountController.addBudgetAccountToFirebase(budgetAccountModel);
    }
  }

  
  void updateGoalToController() {
    if(widget.isUpdateInfo != null) {
      String idUpdate = widget.isUpdateInfo!.id!;  // esto es raro
      String userId = widget.isUpdateInfo!.userid!;
      BudgetAccountModel budgetAccountModel = BudgetAccountModel(
        id: idUpdate,
        userid: userId,
        name: nameController.text, 
        notes: notesController.text, 
        ammount: int.parse(ammountController.text),
        accountType: _selectedTypeAccountId.toString(),
      );
      budgetAccountController.updateBudgetAccountToFirebase(idUpdate, budgetAccountModel);
    }
  }


}