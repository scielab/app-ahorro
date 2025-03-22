import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/size_widget.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/button_base.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencySelectPage extends StatefulWidget {
  const CurrencySelectPage({super.key});

  @override
  State<CurrencySelectPage> createState() => _CurrencySelectPageState();
}

class _CurrencySelectPageState extends State<CurrencySelectPage> {
  Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode('56');
  final AuthController _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const BigText(title: "Selecciona el tipo de moneda que utilizarás en la aplicación.",over: true,alig: true,),
              const SizedBox(height: 50,),
              const Text('Selecciona la moneda de tu país.'),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                child: ListTile(              
                  onTap: _openFilteredCountryPickerDialog,
                  title: _buildDialogItem(_selectedFilteredDialogCountry),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //print(_selectedFilteredDialogCountry.currencyCode);
                  _auth.selectedCountry.value = _selectedFilteredDialogCountry.currencyCode ?? "";
                  if(_auth.getCurrentUser() != null) {
                    Get.offAllNamed(RouterHelper.getHomePrincipalPage());
                  } else {
                    Get.offAllNamed(RouterHelper.getSignin());
                  }

                },
                child: const ButtonBase(title: "Siguiente",primary: true,sizeWidget: SizeWidget.BIG,)),
            ],
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
}
