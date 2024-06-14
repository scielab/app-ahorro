import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/routes/routes.dart';
import 'package:app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerRestable = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();  
    final size = MediaQuery.of(context).size;


    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: const Image(image: AssetImage('assets/images/login_back.jpeg'),fit: BoxFit.cover,),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                  const BigText(
                    title: "Regístrate",
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 20),
                  const SmallText(
                    title: "Si ya registraste previamente con tu correo electrónico, puedes ingresar.",
                    color: Colors.white,
                    size: 16,
                    fw: FontWeight.bold,
                  ),
                  const SizedBox(height: 50),
                  const SmallText(
                    title: "Correo Electronico",
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                      controller: emailController,
                      labelText: "Correo electrónico",
                      enable: true),
                  const SmallText(
                    title: "Contraseña",
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    controller: passwordController,
                    labelText: "Contraseña",
                    isPassword: true,
                    enable: true,
                  ),
                  const SmallText(
                    title: "Volver Contraseña",
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    controller: passwordControllerRestable,
                    labelText: "Contraseña",
                    isPassword: true,
                    enable: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => GestureDetector(
                    onTap: () async => authController.signUpEmailandPasswordValidator(emailController,passwordController,passwordControllerRestable),
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: authController.isSignUp.value ? const CircularProgressIndicator(color: Colors.white) : const BigText(
                          title: "SIGUIENTE",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouterHelper.getSignin());
                    },
                    child: const Center(
                      child: SmallText(
                        title: "Iniciar Sesion",
                        color: Colors.white,
                        fw: FontWeight.bold,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
