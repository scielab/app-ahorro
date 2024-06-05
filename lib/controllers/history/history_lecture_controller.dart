import 'package:app/models/history_model.dart';
import 'package:app/utils/app_resources.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryLectureController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  RxList responseLecture = [].obs;
  late HistoryLecture currentHistoryLecture;
  RxString currentHistoryLectureId = "".obs;

  void setHistoryLecture(HistoryLecture historyLecture) {
    currentHistoryLecture = historyLecture;
  }

  // Get History
  Future<HistoryLecture?> fetchResponseRectures(String iduser) async {
    try {
      final querySnapshot = await db.collection('lectures').where('iduser',isEqualTo: iduser).get();
      if(querySnapshot.docs.isNotEmpty) {
        Map<String,dynamic> json = querySnapshot.docs.first.data();
        currentHistoryLectureId.value = querySnapshot.docs.first.id;
        return HistoryLecture.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
    }
    return null;
  }



  Future<void> createResponseLectures(HistoryLecture historyLecture) async {
    try {
      Future<DocumentReference<Map<String, dynamic>>> history = db.collection('lectures').add(historyLecture.toMap());
      history.then((value) {
        currentHistoryLectureId.value = value.id;
      })
      .catchError((e) {
        logger.e(e);
      });
    } catch (e) {
      logger.e(e);
    }
  }
  Future<void> updateResponseLecture(int lecture) async {
    try {
      if(currentHistoryLectureId.value.isEmpty) throw Exception("No esta definido el id de history lecture");
      await db.collection('lectures').doc(currentHistoryLectureId.value).update({'lecturelist': FieldValue.arrayUnion([lecture])});
    } catch (e) {
      logger.e(e);
    }
  }


}