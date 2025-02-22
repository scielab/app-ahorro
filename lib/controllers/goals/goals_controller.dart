import 'package:app/models/goals_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class GoalsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Lista reactiva para manejar los datos
  var goalsList = <GoalsModel>[].obs;
  late GoalsModel currentGoal;

  @override
  void onInit() {
    super.onInit();
    getGoalsFromFirebase();
  }

  /// **GET**: Leer datos desde Firebase y actualizar la lista local
  Future<void> getGoalsFromFirebase() async {
    try {
      // debemos hacer un filtro el id de usuario para traer todos los del mismo id
      final snapshot = await _firestore.collection('goals').get();
      goalsList.value = snapshot.docs
          .map((doc) => GoalsModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Error al obtener datos: $e');
    }
  }
  
  
  Future<void> getGoalsFromFirebaseByUid(String uid) async {
    try {
      final docSnapshot = await _firestore.collection('goals').doc(uid).get();
      if (docSnapshot.exists) {
        GoalsModel.fromJson(docSnapshot.data()!);
      } else {
        Get.snackbar('Información', 'Meta no encontrada');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error al obtener meta: $e');
    }
  }

  // Que tipo de dato retorna esto
  Future<List<GoalsModel>> getGoalsByUserId(String userId) async {
    try {
      final snapshot = await _firestore.collection('goals').where('userid', isEqualTo: userId).get();
      goalsList.value = snapshot.docs.map((doc) => GoalsModel.fromJson(doc.data())).toList();
      
      return goalsList;
    } catch (e) {
      Get.snackbar('Error', 'Error al filtrar metas: $e');
    }
    return [];
  }


  /// **CREATE**: Agregar una nueva meta a Firebase
  Future<void> addGoalToFirebase(GoalsModel goal) async { 
    try {
      DocumentReference docRef = await _firestore.collection('goals').add(goal.toJson());
      await docRef.update({
        'id': docRef.id,  
      });

      Get.snackbar('Éxito', 'Meta agregada correctamente');
      getGoalsFromFirebase(); // Actualiza la lista local
    } catch (e) {
      Get.snackbar('Error', 'Error al agregar meta: $e');
    }
  }

  /// **UPDATE**: Actualizar una meta existente en Firebase
  Future<void> updateGoalToFirebase(String docId, GoalsModel updatedGoal) async {
    try {
      await _firestore.collection('goals').doc(docId).update(updatedGoal.toJson());
      Get.snackbar('Éxito', 'Meta actualizada correctamente');
      getGoalsFromFirebase(); // Actualiza la lista local
    } catch (e) {
      Get.snackbar('Error', 'Error al actualizar meta: $e');
    }
  }

  /// **DELETE**: Eliminar una meta de Firebase
  Future<void> deleteGoalToFirebase(String docId) async {
    try {
      await _firestore.collection('goals').doc(docId).delete();
      Get.snackbar('Éxito', 'Meta eliminada correctamente');
      getGoalsFromFirebase(); // Actualiza la lista local
    } catch (e) {
      Get.snackbar('Error', 'Error al eliminar meta: $e');
    }
  }
}

