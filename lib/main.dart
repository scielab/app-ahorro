import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/helpers/dependences.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  await init();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put<AuthController>(AuthController());

    return GetMaterialApp(
      title: 'App Ahorrro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: RouterHelper.routes,
      initialRoute: RouterHelper.getSignin(),
    );
  }
}

