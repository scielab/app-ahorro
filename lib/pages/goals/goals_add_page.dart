

import 'package:app/controllers/goals/goals_controller.dart';
import 'package:app/models/goals_model.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/base/button/button_base_widget.dart';
import 'package:app/widgets/base/selected/category_selected.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/input_field.dart';
import 'package:app/widgets/small_text.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsAddPage extends StatefulWidget {
  final bool isUpdate;
  final String userid;
  final GoalsModel? isUpdateInfo;

  const GoalsAddPage({super.key,required this.userid,this.isUpdate = false, this.isUpdateInfo});

  @override
  State<GoalsAddPage> createState() => _GoalsAddPageState();
}

class _GoalsAddPageState extends State<GoalsAddPage> {

  // argumento para indicar si esto es update o add
  late GoalsController goalsController;

  @override
  void initState() {
    super.initState();
    goalsController = Get.find<GoalsController>(); // nota debe ser registrado en dependencias
    if(widget.isUpdate && widget.isUpdateInfo != null) {
      // asignamos todos los tipos de datos aqui
      nameController.text = widget.isUpdateInfo!.name;
      notesController.text = widget.isUpdateInfo!.notes;
      ammountController.text = widget.isUpdateInfo!.ammount.toString();

      if(widget.isUpdateInfo!.accumulatedAmount != 0) {
        light = true;
        acumulatedAmmountController.text = widget.isUpdateInfo!.accumulatedAmount.toString();
      }

    }
  }

  Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode('56');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController ammountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController acumulatedAmmountController = TextEditingController();


  //CategorySelectedWidget
  final categoryCreditCard = [
    {
      'id': 1,
      'label': 'Master Card',
      'icon': Icons.card_giftcard,
    }
  ];
  int _selectedCategoryId = 0;
  String _selectedCategory = '';


  bool light = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Crea una meta")
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
                  // const SmallText(title: "Categoria"),
                  // InputField(controller: categoryController, labelText: "categoria",enable: true),
                
                  const SizedBox(height: 20,),
                  const SmallText(title: "Notas"),
                  InputField(controller: notesController, labelText: "Notas",enable: true),

                  const SizedBox(height: 20,),
                  ButtonBaseWidget(title: _selectedCategory.isNotEmpty ? _selectedCategory : "Icon", onPress: () {
                      Get.to(() =>
                        CategorySelectedWidget(categories: categoryCreditCard, onCategorySelected: (selectedCategoryId,selectedCategory) {
                          _selectedCategory = selectedCategory;
                          _selectedCategoryId = selectedCategoryId;
                          setState(() {
                            
                          });
                        }),
                      );
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
                    child: InputField(controller: acumulatedAmmountController, labelText: "Cantidad Aumulada",enable: true,isNumeric: true),
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
      int accumulatedAmount = int.parse(acumulatedAmmountController.text);

      GoalsModel goalsModel = GoalsModel(
        userid: widget.userid,
        name: nameController.text, 
        divisa: _selectedFilteredDialogCountry.currencyCode.toString(),
        notes: notesController.text, 
        category: _selectedCategoryId, 
        ammount: int.parse(ammountController.text), 
        accumulatedAmount: accumulatedAmount,

      );
      goalsController.addGoalToFirebase(goalsModel);
    }
  }

  void updateGoalToController() {
    if(widget.isUpdateInfo != null) {
      String idUpdate = widget.isUpdateInfo!.id!;  // esto es raro
      String userId = widget.isUpdateInfo!.userid;

      int accumulatedAmount = int.parse(acumulatedAmmountController.text);

      GoalsModel goalsModel = GoalsModel(
        id: idUpdate,
        userid: userId,
        name: nameController.text, 
        divisa: _selectedFilteredDialogCountry.currencyCode.toString(),
        notes: notesController.text, 
        category: _selectedCategoryId, 
        ammount: int.parse(ammountController.text), 
        accumulatedAmount: accumulatedAmount,
      );
      goalsController.updateGoalToFirebase(idUpdate, goalsModel);
    }
  }


}