import 'package:app/controllers/auth/email_verification_controller.dart';
import 'package:app/routes/routes.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationEmailPage extends StatefulWidget {
  const VerificationEmailPage({super.key});

  @override
  State<VerificationEmailPage> createState() => _VerificationEmailPageState();
}

class _VerificationEmailPageState extends State<VerificationEmailPage> {
  EmailVerificationController evc = Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              const Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Icon(Icons.email),
                    BigText(title: "Verificar tu direccion de correo"),
                    SizedBox(height: 20),
                    SmallText(title: "Se ha enviado un mensje de verificacion a tu correo"),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
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
                          child: SmallText(title: "Continuar",fw: FontWeight.bold,color: Colors.white,size: 25,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: const SmallText(title: "Reenviar email")),
                    const SizedBox(height: 30,),
                    GestureDetector(
                      onTap: () {
                        Get.offAndToNamed(RouterHelper.getSignin());
                      },
                      child: const SmallText(title: "Volver a la pagina del login")),    
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