import 'package:app/widgets/base/input/input_field_area.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/input_field.dart';
import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class Supportpage extends StatefulWidget {
  const Supportpage({super.key});

  @override
  State<Supportpage> createState() => _SupportpageState();
}

class _SupportpageState extends State<Supportpage> {
  TextEditingController messageControlle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: BigText(title: "Centro de Ayuda"),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const BigText(title: "Enviar un correo a soporte"),
              const SizedBox(height: 10,),
              //InputField(controller: messageControlle, labelText: "Enviar un Mensaje",enable : true),
              InputFieldArea(controller: messageControlle),
               const Spacer(),
              GestureDetector(
                onTap: () {
                  //Get.to(() => const SplashScreenLoader());
                },
                child: Container(
                  width: size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                  child: const Center(
                    child: SmallText(title: "Enviar",fw: FontWeight.bold,color: Colors.white,size: 25,),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}