import 'dart:async';
import 'package:app/controllers/history/history_atributes_profile.dart';
import 'package:app/models/atributes_profile_model.dart';
import 'package:app/pages/auth/verification_page.dart';
import 'package:app/routes/routes.dart';
import 'package:app/utils/app_debug_reports.dart';
import 'package:app/utils/generate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  
  late final SharedPreferences _prefs;
  RxString selectedCountry = RxString("");
  Rx<User?> user = Rx<User?>(null);

  FirebaseAuth get firebaseAuth => _firebaseAuth;


  RxBool isSignUp = false.obs;
  RxBool isSignIn = false.obs;

  @override
  void onInit() async {
    _prefs = await SharedPreferences.getInstance();
    _firebaseAuth.authStateChanges().listen((User? firebaseuser) {
      user.value = firebaseuser;
    });
    ever(user, (callback) => _setInitialScreen(user.value));
    super.onInit();
  }

  // Esta funcion verifica si existe unusuario o no y redirige dependiendo el caso (Es una copia)
  void setInitialScreen(User? user) {
    if(user != null) {
      if(user.emailVerified) {
        Get.offAllNamed(RouterHelper.getHomePrincipalPage());
      } else {
        Get.offAll(() => const VerificationEmailPage());
      }
    } else {
      _prefs.remove('lastExecution');
      Get.toNamed(RouterHelper.presentation);
      //Get.to(() => SplashAds());
    }
  }

  // Esta funcion verifica si existe unusuario o no y redirige dependiendo el caso 
  void _setInitialScreen(User? user) {
    if(user != null) {
      if(user.emailVerified) {
        Get.offAllNamed(RouterHelper.getHomePrincipalPage());
      } else {
        Get.offAll(() => const VerificationEmailPage());
      }
    } else {
      Get.toNamed(RouterHelper.presentation);
      //Get.to(() => SplashAds());
    }
  }

  Future<void> sendEmailVerificationAccount() async {
    try {
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (exception) {
      logger.e(exception);
    }catch (e) {
      logger.e(e);
    }
  }
  
  Future<bool> signUpEmailandPassword(String email, String password) async {
    try {
      isSignUp.value = true;
      final UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      user.value = credential.user;
      if(user.value != null) {
        logger.d("Entro por lo tanto el usuario no es nulo");
        final form = {
          'name': generateNumberAvatar(),
          'email': email,
          'photo': user.value?.photoURL ?? '',
          'uid': user.value?.uid,
        };
        db.collection('users').doc(user.value?.uid).set(form);
        createHistoryAtributeProfile(user.value!.uid);

        //Es necesario guardar toda esta informacion?
        _prefs.setString('session','EMAIL');
        _prefs.setString('name', form['name'] as String);
        _prefs.setString('email', form['email'] as String);
        _prefs.setString('photo', form['photo'] as String);
        _prefs.setString('uid', form['uid'] as String);
      
        _prefs.setBool('jumptutorial', true);
        _prefs.setString('divisa', selectedCountry.value);
        _prefs.setBool('question', true);
        isSignUp.value = false;
        
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          logger.e('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          logger.e('The account already exists for that email.');
        }
    }
    catch (e) {
      logger.e(e);
    }
    return false;
  }

  /* Esta funcion crea los atributos de perfil cuando el atributo del usuario no existe */
  Future<void> createHistoryAtributeProfile(String useruid) async {
    AtributeProfileController atributeProfileController = AtributeProfileController();
    bool existAtributeProfile = await atributeProfileController.existAtributeProfile(useruid);
    if(!existAtributeProfile) {
      AtributeProfile atributeProfile = AtributeProfile(userid: useruid, energy: 0, guias: 0, lectures: 0, typeLevel: TypeLevel.beginner);
      await atributeProfileController.createAtributesProfile(atributeProfile);
    }
  }


  Future<bool> signInEmailAndPassword(String email,String password) async {
    try {
      final UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      user.value = credential.user;
      if(user.value != null) {
        _prefs.setString('uid', user.value!.uid);
        _prefs.setString('email', email);
        _prefs.setString('session','EMAIL');
        _prefs.setBool('question', true);
      }
      Get.snackbar("exito al entrar","entrar");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.e('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        logger.e('Wrong password provided for that user.');
        return false;
      }
    }
    return false;
  }


  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signOut() async {
    _prefs.remove('session');
    await _firebaseAuth.signOut();
  }

  // google  
  Future<bool> handlerGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser =  await _googleSignIn.signIn();
      if(googleUser == null) {
        logger.e("Usuario null");
        return false; // cancelo el inicio de sesion
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      final UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      
      if(user != null) {
         final form = {
           'name': generateNumberAvatar(),
           'email': user.email,
           'photo': user.photoURL?? '',
           'uid': user.uid,
        };
        db.collection('users').doc(user.uid).set(form);
        _prefs.setString('session','GOOGLE');
        _prefs.setBool('question', true);
      
        //await createHistoryAtributeProfile(user.uid);

        return true;
      } else {
        return false;
      }
    } catch (error) {
      logger.e(error);
    }
    return false;
  }

  Future<void> handleGoogleSignOut() async {
    _prefs.remove('session');
    _googleSignIn.disconnect();
  }

  Future<void> handleGoogleSignIn() async {
    bool response = await handlerGoogleSignIn();
    if (response) {
      logger.d("Entro");
    } else {
      logger.d("NO ENTRO");
    }
  }

  Future<void> signOutSession() async {
    try {
      var op = _prefs.getString('session');
      if(op != null) {
        switch(op) {
          case 'GOOGLE':
            await signOut();
            await handleGoogleSignOut();
            break;
          case 'EMAIL':
            await signOut();
            break;
          default:
            throw Exception("No especificado el tipo de session");
        }
      } 
    } catch (error) {
      logger.e(error);
    }
  }

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
      Get.snackbar("Error", "Tiene campos vacios",backgroundColor: Colors.blue,colorText: Colors.white);
    }
    if(!_validateEmail(_email)) {
      Get.snackbar("Error", "Error email no valido",backgroundColor: Colors.blue,colorText: Colors.white);
    }
    if(_pass != _confirm_pass) {
      Get.snackbar("Error", "Las cotraseñas no son iguales",backgroundColor: Colors.blue,colorText: Colors.white);
    }

    logger.d("Paso la validacion de campos");
    bool register = await signUpEmailandPassword(_email,_pass);
    if(register) {
    } else {
      Get.snackbar("Inicio de Sesion", "No puedo entrar",backgroundColor: Colors.blue,colorText: Colors.white);
    }
  }


  Future<void> signInEmailandPasswordValidator(TextEditingController email, TextEditingController pass) async {
    String _email = email.text.trim();
    String _pass = pass.text.trim();

    if(_email.isEmpty || _pass.isEmpty) {
      Get.snackbar("Error", "Tiene campos vacios",backgroundColor: Colors.blue,colorText: Colors.white);
    }
    if(!_validateEmail(_email)) {
      Get.snackbar("Error", "Error email no valido",backgroundColor: Colors.blue,colorText: Colors.white);
    }
    bool register = await signInEmailAndPassword(_email,_pass);
    if(register) {
      logger.d("Exito al entrar");
    } else {
      logger.d("No puedo entrar");
      Get.snackbar("Inicio de Sesion", "No puedo entrar",backgroundColor: Colors.blue,colorText: Colors.white);

    }
  }

  
  // delete account:
  Future<void> removeAccount() async {
    try {
      if(user.value == null) throw Exception("La cuenta no esta registrada");
      
      await deleteInfoAssociatedAccount(user.value!.uid);
      var userAuth = await getCurrentUser()!.delete();
    } catch (e) {
      logger.e(e);
    }
  }

  
  Future<void> deleteInfoAssociatedAccount(String userid) async {
    // budget
    final batch = FirebaseFirestore.instance.batch();
    final budgetQuery = await db.collection('budget').where('userid',isEqualTo: userid).get();
    for(final doc in budgetQuery.docs) {
      batch.delete(doc.reference);
    }
    // history
    final historyQuery = await db.collection('history').where('iduser',isEqualTo: userid).get();
    for(final doc in historyQuery.docs) {
      batch.delete(doc.reference);
    }
    // lectures
    final lecturesQuery = await db.collection('lectures').where('iduser',isEqualTo: userid).get();
    for(final doc in lecturesQuery.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(FirebaseFirestore.instance.collection('users').doc(userid));
    await batch.commit();
  }

}

