import 'dart:async';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/models/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Rx<User?> user = Get.find<AuthController>().user;
  RxList<TransactionBase> transactions = <TransactionBase>[].obs;
  bool isLoading = false;

  // creacion de un campo actual
  //TransactionBase currentTransaction;
  void addBudgetToFirebase(TransactionBase form) {
    Future<DocumentReference<Map<String, dynamic>>> budget = db.collection('budget').add(form.toMap());
    budget.then((value) => {
      print("Usuario Agregado")
    })
    .catchError((error) => print("Failed to add user: $error"));
  }


  Future<void> getBudgetFilterDate(DateTime date) async { 
    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where("date", isEqualTo: date);
    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data()));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      print("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }

 Future<void> getBudgetFilterMonth() async { 
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + 1, 1).subtract(Duration(days: 1));


    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where('date', isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data()));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      print("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }


 Future<List<TransactionBase>> getBudgetFilterMonthData() async { 
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + 1, 1).subtract(Duration(days: 1));


    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where('date', isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data()));
      }
      return updatedTransactions;
      //transactions.assignAll(updatedTransactions);
    } catch (e) {
      print("Error completing $e");
    }
    return [];
  }

 Future<void> getBudgetFilterWeek() async {
    DateTime currentDate = DateTime.now();
    DateTime startDate = currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime endDate = startDate.add(const Duration(days: 6));

    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where('date', isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data()));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      print("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }

 Future<void> getBudgetFilterDay() async { 
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateTime endDate = startDate.add(const Duration(days: 1));
    
    print(startDate);
    print(endDate);

    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where('date', isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data()));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      print("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }


  Future<void> getBudgetRecentToFirebase(String type) async {
    final docRef = db.collection("budget")
      .where("userid", isEqualTo: user.value?.uid)
      .where("type", isEqualTo: type);
    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data()));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      print("Error completing: $e");
      completer.completeError(e); // Completa el futuro con error si ocurre un error
    }
    return completer.future;
  }



  /*
  Future<bool> deleteBudgetToFirebase() {}
  Future<bool> updateBudgetToFirebase() {}
  Future<void> getBudgetRecentToFirebase() {}
  Future<void> getBudgetFilterbyDateToFirebase(DateTime date) {}
  Future<void> getBudgetFilterbycategoryToFirebase(DateTime date) {}
  */


}