import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/pages/conf/suport_page.dart';
import 'package:app/pages/payments/payment_page.dart';
import 'package:app/pages/currency_select_page/currency_select_page.dart';
import 'package:app/pages/splash/into/splash_screen_select.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/dialog_widget.dart';
import 'package:app/widgets/item_list_conf.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Perfil"),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                const SmallText(title: "Configuracion",fw: FontWeight.bold,),
                const SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const Supportpage());
                        },
                        child: const ItemListConf(title: "Centro de ayuda", icon: Icons.edit_document)),
                      const ItemListConf(title: "Comentarios", icon: Icons.message),
                      const ItemListConf(title: "Califícanos", icon: Icons.library_add_check_rounded),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => PaymentPage());
                        },
                        child: const ItemListConf(title: "Subscribirse", icon: Icons.payment),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SplashSreenSelect());
                        },
                        child: const ItemListConf(title: "Cambiar Dificultad", icon: Icons.account_tree_rounded),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CurrencySelectPage());
                        },
                        child: const ItemListConf(title: "Cambiar moneda", icon: Icons.monetization_on),
                      ),
                      GestureDetector(
                        onTap: () {
                          //print("Cerrar Session");
                          authController.signOutSession();
                        },
                        child: const ItemListConf(title: "Cerrar Sesión", icon: Icons.exit_to_app),
                      ),
                      GestureDetector(
                        onTap: () {
                          // lanzar un dialog
                          showDialog(context: context, builder: (context) {
                            return DialogWidget(
                              title: "Eliminar cuenta permanentemente",
                              description: "¿Seguro quieres eliminar la cuenta? Perderás todo tu progreso.",
                              okFunction: () {
                                authController.removeAccount();
                              },
                              cancelFunction: () {},
                            );  
                          });
                        },
                        child: const ItemListConf(title: "Eliminar cuenta de usuario", icon: Icons.person),
                      ),
            
                    ],
                  ),
                ),
            
              ],
            ),
          ),
        ),
    );
  }



}
