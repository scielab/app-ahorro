import 'package:app/models/financial_account_model.dart';
import 'package:app/models/analytics_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FinancialAccountController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<AnalyticItem> analytics = <AnalyticItem>[].obs;


  // Lista reactiva para manejar los datos
  var goalsList = <BudgetAccountModel>[].obs;
  late BudgetAccountModel currentBudgetAccount;

  @override
  void onInit() {
    super.onInit();
    getBudgetAccountFromFirebase();
  }

  Future<void> getBudgetAccountFromFirebase() async {
    try {
      // debemos hacer un filtro el id de usuario para traer todos los del mismo id
      final snapshot = await _firestore.collection('budget_account').get();
      goalsList.value = snapshot.docs
          .map((doc) => BudgetAccountModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Error al obtener datos: $e');
    }
  }
  
  
  Future<void> getBudgetAccountFromFirebaseByUid(String uid) async {
    try {
      final docSnapshot = await _firestore.collection('budget_account').doc(uid).get();
      if (docSnapshot.exists) {
        BudgetAccountModel.fromJson(docSnapshot.data()!);
      } else {
        Get.snackbar('Información', 'Meta no encontrada');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al obtener meta: $e');
    }
  }

  Future<List<BudgetAccountModel>> getBudgetAccountByUserId(String userId) async {
    try {
      final snapshot = await _firestore.collection('budget_account').where('userid', isEqualTo: userId).get();
      goalsList.value = snapshot.docs.map((doc) => BudgetAccountModel.fromJson(doc.data())).toList();
      
      return goalsList;
    } catch (e) {
      Get.snackbar('Error', 'Error al filtrar metas: $e');
    }
    return [];
  }


  Future<void> addBudgetAccountToFirebase(BudgetAccountModel budgetAccount) async { 
    try {
      DocumentReference docRef = await _firestore.collection('budget_account').add(budgetAccount.toJson());
      await docRef.update({
        'id': docRef.id,  
      });

      Get.snackbar('Éxito', 'Meta agregada correctamente');
    } catch (e) {
      Get.snackbar('Error', 'Error al agregar meta: $e');
    }
  }

  Future<void> updateBudgetAccountToFirebase(String docId, BudgetAccountModel updatedBudget) async {
    try {
      await _firestore.collection('budget_account').doc(docId).update(updatedBudget.toJson());
      Get.snackbar('Éxito', 'Meta actualizada correctamente');
    } catch (e) {
      Get.snackbar('Error', 'Error al actualizar meta: $e');
    }
  }

  Future<void> deleteBudgetAccountToFirebase(String docId) async {
    try {
      await _firestore.collection('budget_account').doc(docId).delete();
      Get.snackbar('Éxito', 'Meta eliminada correctamente');
    } catch (e) {
      Get.snackbar('Error', 'Error al eliminar meta: $e');
    }
  } 

  // transacciones:
  // Future<void> createTransactionFinancialBudgetAccount() async {} // implementar un tipo de transaccion personalizada en el modelo
  // Future<void> getTransactionFinancialBudgetAccount() async {}
  // Future<void> deleteTransactionFinancialBudgetAccount(String docId) async {}



  // Estadisticas:

  void getPorcentFinancialBudgetAccount(String type, RxList<BudgetAccountModel> budgetAccountModel) {
    analytics.clear();
    double totalAmountBudget = budgetAccountModel
        .where((tr) => tr.accountType.toString() == type)
        .fold(0, (previous, current) => previous + current.ammount);

    // recorrer el conjunto de categorias
    print(totalAmountBudget);
  }

}