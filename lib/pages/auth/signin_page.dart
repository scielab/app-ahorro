import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              width: size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  const BigText(
                    title: "Iniciar Sesión",
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(height: Dimension.height45),
                  const SmallText(
                    title: "Si ya registraste previamente con tu correo electrónico, puedes ingresar.",
                    color: Colors.white,
                    size: 16,
                    fw: FontWeight.bold,
                    over: true,
                  ),
                  const SizedBox(height: 50),
                  const SmallText(
                    title: "Correo electrónico",
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 10),
                  InputField(controller: emailController, labelText: "Correo electronico",enable: true,),
              
                  const SmallText(
                    title: "Contraseña",
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 17,
                  ),
                  const SizedBox(height: 10,),
                  InputField(controller: passwordController, labelText: "contraseña",isPassword: true,enable: true),
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () => authController.signInEmailandPasswordValidator(emailController,passwordController),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: BigText(
                          title: "SIGUIENTE",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimension.height15),
                  Center(
                    child: GestureDetector(
                      onTap: () => authController.handleGoogleSignIn(),
                      child: Container(
                        width: size.width * 0.5,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/icons/icons8-logo-de-google-48.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const SmallText(title: "Google"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouterHelper.getSignup());
                    },
                    child: const Center(
                      child: SmallText(
                        title: "Registrarse",
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
