import 'dart:convert';
import 'dart:math';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/history/history_lecture_controller.dart';
import 'package:app/models/content_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/models/rutines_model.dart';
import 'package:app/utils/app_resources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';


Map<String,String> dificulty = {
  'beginner': 'Principiante',
  'intermediate': 'Intermedio',
  'advanced': 'Avanzado'
};

class ActivityControlller extends GetxController {
  late SharedPreferences _prefs;

  late List<ContentModel> content;

  RxList<dynamic> lectures = <dynamic>[].obs;
  RxList<ContentModel> recommended = <ContentModel>[].obs;


  RxList<Map<String,dynamic>> names = <Map<String,dynamic>>[].obs;
  RxList<String> rutines = <String>[].obs;
  RxList<Rutine> rutinesList = <Rutine>[].obs;

  late HistoryLectureController historyLectureController;
  late RxString difficulty;
  RxBool isLoadingLectures = false.obs;


  Future<bool> isDificultySelected() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool response = false;
    sharedPreferences.getString('dificulty') != null ? response = true :  response = false;
    return response; 
  }
  Future<void> selectDificulty(String select) async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('dificulty', select);
  }

  @override
  void onInit() async {
    _prefs = await SharedPreferences.getInstance();

    loadNames();
    loadRutines();
    loadLectures();

    rutinesList.addAll([
        Rutine(name: 'Registra tu presupuesto diario!', description: 'Descripción de la rutina 1', activeDay: [1, 2, 3, 4, 5],type: "budget"), // Lunes a viernes
        if(recommended.isNotEmpty) Rutine(name: 'Aprender Fundamentos diarios!', description: 'Aprender', activeDay: [1, 2, 3, 4, 5, 6, 7],type: "lecture"), // Sábado a miércoles
    ]);

    await loadHistoryLectures();



    super.onInit();
  }

  List<Rutine> getTodayRutines() {
    final rutinesData = rutinesList.where((element) => isRutineActivate(element)).toList();
    return rutinesData;
  }

  bool isRutineActivate(Rutine rutine) {
    int currentDay = DateTime.now().weekday;
    int nextWeek = (currentDay + 7) % 7;
    return rutine.activeDay.contains(currentDay) || rutine.activeDay.contains(nextWeek); 
  } 

  Future<void> loadLectures() async {
    String jsonData = await rootBundle.loadString('assets/data/lecture/principal.json');
    List<dynamic> dataList = jsonDecode(jsonData);
    lectures.value = dataList;


  }
  
  Future<void> loadNames() async {
    String jsonData = await rootBundle.loadString('assets/data/lecture/principal.json');
    List<dynamic> dataList = jsonDecode(jsonData);
    names.assignAll(dataList.map((data) {
      return {
        'title': data['title'].toString(),
        'id': data['id'],
      };
      }
    ));
  }

  Future<void> loadRutines() async {
    String jsonData = await rootBundle.loadString('assets/data/lecture/rutines.json');
    List<dynamic> dataList = jsonDecode(jsonData);
    rutines.assignAll(dataList.map((data) => data['title'].toString()));
  }

  List<int> recommendedLectures() {
    if(lectures.isEmpty || !isLoadingLectures.value) return [];
    DateTime lastExecution = DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('lastExecution') ?? 0);

    if (DateTime.now().difference(lastExecution).inDays >= 1) {
      List<int> selected = [];
      int cont = 0;
      int intee = 0;
      while(cont < 3) {
        int random = Random().nextInt(lectures.length) + 1;
        if (!historyLectureController.currentHistoryLecture.lectures.contains(random)) {
          selected.add(random);
          cont++;
        }
        if(intee == 50) {
          break;
        }
        intee++;
      }
      _prefs.setInt('lastExecution', DateTime.now().millisecondsSinceEpoch);
      _prefs.setStringList('recommendedLectures', selected.map((id) => id.toString()).toList());
      logger.d("Generando nuevas recomendaciones");
      logger.d(selected);
      return selected;
    } else {
      List<int> results = _prefs.getStringList('recommendedLectures')?.map((id) => int.parse(id)).toList() ?? [];

      logger.d("Obteniendo recomendaciones antiguas");
      logger.d(results);
      return results;
    }
  }


  List<ContentModel> getLecturesfromId(List<int> selected) {
    return lectures.map((element) {
      if (selected.contains(element['id'])) { 
        return ContentModel.fromJson(element);
      }
    }).whereType<ContentModel>().toList();
  }


  // No se si esto es un mala practica llamar un controlador desde aqui
  Future<void> loadHistoryLectures() async {
    try {
      User? user = Get.find<AuthController>().getCurrentUser();
      if(user != null) {
        historyLectureController = Get.find<HistoryLectureController>();
        var history = await historyLectureController.fetchResponseRectures(user.uid);
        if(history == null) {
          logger.d(history);
          HistoryLecture historyLecture = HistoryLecture(iduser: user.uid, lectures: []);
          await historyLectureController.createResponseLectures(historyLecture);
          historyLectureController.setHistoryLecture(historyLecture);
          isLoadingLectures.value = true;
        } else {
          historyLectureController.setHistoryLecture(history);
          isLoadingLectures.value = true;
        }
        List<int> data = recommendedLectures();
        recommended.value = getLecturesfromId(data);
      } 
    } catch (e) {
      logger.e(e);
    }
  }
}