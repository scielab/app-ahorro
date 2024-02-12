import 'package:app/pages/presentation/badge_page.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/generate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  //late final SharedPreferences _prefs;

  //Rx<User?> user = Rx<User?>(null);
  //late User? user;
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    _firebaseAuth.authStateChanges().listen((User? firebaseuser) {
      user.value = firebaseuser;
    });
    ever(user, (callback) => _setInitialScreen(user.value));
    super.onInit();
  }


  void _setInitialScreen(User? user) {
    if(user != null) {
      Get.offAndToNamed(RouterHelper.getHomePrincipalPage());
      //Get.offAll(BadgePage());
    } else {
      Get.toNamed(RouterHelper.getSignin());
    }
  }

  Future<bool> signUpEmailandPassword(String email, String password) async {
    try {
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      user.value = credential.user;
      print(user.value);
      // add user information to database
      if(user.value != null) {
        final form = {
          'name': generateNumberAvatar(),
          'email': email,
          'photo': user.value?.photoURL ?? '',
          'uid': user.value?.uid,
        };
        db.collection('users').doc(user.value?.uid).set(form);
        //_prefs = await SharedPreferences.getInstance();
        //Es necesario guardar toda esta informacion?
        //_prefs.setString('name', form['name'] as String);
        //_prefs.setString('email', form['email'] as String);
        //_prefs.setString('photo', form['photo'] as String);
        //_prefs.setString('uid', form['uid'] as String);
      }

      return true;
    } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
    }
    catch (e) {
      print(e);
    }
    return false;
  }
  
  Future<bool> signInEmailAndPassword(String email,String password) async {
    try {
      //_prefs = await SharedPreferences.getInstance();
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user.value = credential.user;
      // Agregar un condicional en caso que necesite guardar o no
      //_prefs.setString('uid', user.value!.uid);
      print(user);
      Get.snackbar("exito al entrar","entrar");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
    return false;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  // Implementation google:
  // Registration google account:

  // login:
  
  // Future<bool> handlerGoogleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleUser =  await _googleSignIn.signIn();
  //     if(googleUser == null) return false; // cancelo el inicio de sesion

  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken
  //     );

  //     final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
  //     final User? user = authResult.user;
      
  //     if(user != null) {
  //       print("Usuario autenticado con exito");

  //       /*
  //       final form = {
  //         'name': name,
  //         'email': email,
  //         'photo': user.value?.photoURL ?? '',
  //         'uid': user.value?.uid,
  //       };
  //       db.collection('users').doc(user.value?.uid).set(form);
  //       */

        
  //       // lanzar notificacion
  //       return true;
  //     } else {
  //       // Algo salio mal 
  //       // lanzar notificacion de error
  //       return false;
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  //   return false;
  // }
  // Future<void> _handleGoogleSignOut() => _googleSignIn.disconnect();


  bool _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  // Validaciones de la page
  Future<void> signUpEmailandPasswordValidator(TextEditingController email, TextEditingController pass, TextEditingController confirm_pass) async {
    String _email = email.text.trim();
    String _pass = pass.text.trim();
    String _confirm_pass = confirm_pass.text.trim();

    if(_email.isEmpty || _pass.isEmpty || _confirm_pass.isEmpty) {
      print("Error campos vacios");
    }
    if(!_validateEmail(_email)) {
      print("Error email no valido");
    }
    if(_pass != _confirm_pass) {
      print("Error las contraseñas no son iguales");
    }

    bool register = await signUpEmailandPassword(_email,_pass);
    if(register) {
      print("Exito al entrar");
    } else {
      print("No puedo entrar");
    }
  }


  Future<void> signInEmailandPasswordValidator(TextEditingController email, TextEditingController pass) async {
    String _email = email.text.trim();
    String _pass = pass.text.trim();

    if(_email.isEmpty || _pass.isEmpty) {
      print("Error campos vacios");
    }
    if(!_validateEmail(_email)) {
      print("Error email no valido");
    }
    bool register = await signInEmailAndPassword(_email,_pass);
    if(register) {
      print("Exito al entrar");
    } else {
      print("No puedo entrar");
    }
  }

}

