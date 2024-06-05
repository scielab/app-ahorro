import 'dart:async';
import 'package:intl/intl.dart';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/models/transaction_model.dart';
import 'package:app/utils/app_resources.dart';
import 'package:app/utils/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Rx<User?> user = Get.find<AuthController>().user;
  RxList<TransactionBase> transactions = <TransactionBase>[].obs;
  bool isLoading = false;

  void addBudgetToFirebase(TransactionBase form) {
    Future<DocumentReference<Map<String, dynamic>>> budget = db.collection('budget').add(form.toMap());
    budget.then((value) => {
    })
    .catchError((error) {
      logger.e("Failed to add user: $error");
    });
  }

  Future<void> deleteBudgetToFirebase(String uid) async {
    try {
      await db.collection('budget').doc(uid).delete();
    } catch(e) {
      logger.e(e);
    }
  }
  Future<void> updateBudgetToFirebase(TransactionBase form, String uid) async {
    try {
      await db.collection('budget').doc(uid).update(form.toMap());
    } catch(e) {
      logger.e(e);
    }
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
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(),docSnapshot.id));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      logger.e("Error completing $e");
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
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(),docSnapshot.id));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      logger.e("Error completing $e");
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
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(),docSnapshot.id));
      }
      return updatedTransactions;
      //transactions.assignAll(updatedTransactions);
    } catch (e) {
      logger.e("Error completing $e");
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
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(),docSnapshot.id));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      logger.e("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }

 Future<void> getBudgetFilterDay() async { 
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    DateTime endDate = startDate.add(const Duration(days: 1));

    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where('date', isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(),docSnapshot.id));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      logger.e("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }

  Future<void> getBudgetRecentToFirebase(String type) async {
    DateTime currentDate = DateTime.now();
    DateTime startDate = DateTime(currentDate.year, currentDate.month, 1);
    DateTime endDate = DateTime(currentDate.year, currentDate.month + 1, 1).subtract(const Duration(days: 1));
    final docRef = db.collection("budget")
      .where("userid", isEqualTo: user.value?.uid)
      .where("type", isEqualTo: type);
    Completer<void> completer = Completer<void>();

    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {
        var transactionDate = (docSnapshot.data()['date'] as Timestamp).toDate();
        if (transactionDate.isAfter(startDate) &&  transactionDate.isBefore(endDate)) {
          updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(), docSnapshot.id));
        } 
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      logger.e("Error completing: $e");
      completer.completeError(e); // Completa el futuro con error si ocurre un error
    }
    return completer.future;
  }

  Future<void> getBudgetFilterbyDateToFirebase(DateTime date,String type) async {
    String dateString = convertDateToFirestoreFormat(date);
    final docRef = db.collection("budget")
      .where("userid",isEqualTo: user.value?.uid)
      .where("type", isEqualTo: type);
    Completer<void> completer = Completer<void>();
    try {
      var querySnapshot = await docRef.get();
      List<TransactionBase> updatedTransactions = [];
      for (var docSnapshot in querySnapshot.docs) {

        var data = docSnapshot.data();
        var firestoreDate = data['date'];
        var formattedFirestoreDate = DateFormat("yyyy-MM-dd").format(firestoreDate.toDate());
        if (formattedFirestoreDate == dateString) {
          updatedTransactions.add(TransactionBase.transactionFromFirebase(data, docSnapshot.id));
        }
        //updatedTransactions.add(TransactionBase.transactionFromFirebase(docSnapshot.data(),docSnapshot.id));
      }
      transactions.assignAll(updatedTransactions);
      completer.complete();
    } catch (e) {
      logger.e("Error completing $e");
      completer.completeError(e); 
    }
    return completer.future;
  }
  

}