import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/models/history_model.dart';
import 'package:app/utils/app_debug_reports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class HistoryController extends GetxService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late AuthController _auth;
  late HistoryModel _historyModel;
  late String currentHistory;


  void setHistoryModel(HistoryModel historyModel) {
    _historyModel = historyModel;
  }

  void initialHistory() {
    _auth = Get.find<AuthController>();
  }

  Future<HistoryModel?> getHistoryModel(String userId, String courseId) async {
    try {
      var querySnapshot  = await db.collection('history')
        .where("iduser",isEqualTo: userId)
        .where("idcourse", isEqualTo: courseId).get();
        if (querySnapshot.docs.isNotEmpty) {
          currentHistory = querySnapshot.docs.first.id;
          return HistoryModel.fromQuery(querySnapshot.docs.first);
        } else {
          return null;
        }
    } catch (error) {
      logger.e(error);
    }
    return null;
  }
  Future<void> createHistoryModel(HistoryModel historyModel) async {
    try {
      Future<DocumentReference<Map<String, dynamic>>> history = db.collection('history').add(historyModel.toMap());

      history.then((value) {
        logger.d("Historial Agregado");
        currentHistory = value.id;
      })
      .catchError((error) {
        logger.e("Failed to Hisory: $error");
      });
    } catch (error) {
      logger.e(error);
    }
  } 
  Future<void> updateLesson(Lesson lesson) async {
    try {
      db.collection('history').doc(currentHistory).update({
        'lessonlist': FieldValue.arrayUnion([lesson.toMap()])
      });
    } catch (error) {
      logger.e(error);
    }
  }

  bool completedLesson(String idlesson) {
    print("Entro a la funcio de completed lesson");
    if(_historyModel != null) {
      Lesson? existLesson = _historyModel!.lessonList.firstWhereOrNull(
        (element) => element.idLesson == idlesson);
      if(existLesson != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

}