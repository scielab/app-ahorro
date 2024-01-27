

import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/item_list_conf.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Perfil"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              const SmallText(title: "Ayuda y Comentarios",fw: FontWeight.bold,),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    ItemListConf(title: "Centro ayuda", icon: Icons.edit_document),
                    ItemListConf(title: "Comentarios", icon: Icons.message),
                    ItemListConf(title: "Calificanos", icon: Icons.library_add_check_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              const SmallText(title: "Configuracion",fw: FontWeight.bold,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ItemListConf(title: "Centro ayuda", icon: Icons.edit_document),
                    ItemListConf(title: "Comentarios", icon: Icons.message),
                    ItemListConf(title: "Calificanos", icon: Icons.library_add_check_rounded),
                    GestureDetector(
                      onTap: () => Get.find<AuthController>().signOut(),
                      child: ItemListConf(title: "Cerrar Sesion", icon: Icons.exit_to_app),
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