import 'dart:convert';
import 'dart:math';
import 'package:app/controllers/auth/auth_controller.dart';
import 'package:app/controllers/history/history_lecture_controller.dart';
import 'package:app/helpers/shared_preferences_services.dart';
import 'package:app/models/content_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/models/rutines_model.dart';
import 'package:app/service/repository/content_repo.dart';
import 'package:app/utils/app_debug_reports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';


Map<String,String> dificulty = {
  'BE': 'Beginner',
  'IN': 'Intermediate',
  'AD': 'Advanced'
};


class ActivityControlller extends GetxController {
  late SharedPreferences _prefs;
  late List<ContentModel> content;
  final ContentRepo contentRepo;

  ActivityControlller({required this.contentRepo});

  RxList<dynamic> lectures = <dynamic>[].obs;
  RxList<ContentModel> recommended = <ContentModel>[].obs;


  RxList<Map<String,dynamic>> names = <Map<String,dynamic>>[].obs;
  RxList<String> rutines = <String>[].obs;
  RxList<Rutine> rutinesList = <Rutine>[].obs;

  late HistoryLectureController historyLectureController;
  late RxString difficulty;
  RxBool isLoadingLectures = false.obs;
  
  Future<bool> isDificultySelected() async {
    bool response = false;
    Get.find<SharedPrefsService>().getString('difficulty') != null ? response = true :  response = false;
    return response; 
  }

  Future<void> selectDificulty(String select) async {
    await Get.find<SharedPrefsService>().setString('difficulty', select);
  }

  String getDifficultyCache() {
    return _prefs.getString('difficulty').toString();
  }

  @override
  void onInit() async {
    _prefs = await SharedPreferences.getInstance();

    loadRutines();
    loadLectures();

    rutinesList.addAll([
        Rutine(name: 'Registra tu presupuesto diario!', description: 'Descripción de la rutina 1', activeDay: [1, 2, 3, 4, 5,6,7],type: "budget"), // Lunes a viernes
        if(recommended.isNotEmpty) Rutine(name: 'Aprender Fundamentos diarios!', description: 'Aprender', activeDay: [1, 2, 3, 4, 5, 6, 7],type: "lecture"), // Sábado a miércoles
    ]);

    //await loadHistoryLectures();
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
    try {
      String difficultyPref = getDifficultyCache();
      final response = await contentRepo.getAllContent(difficultyPref);
      List<dynamic> datalist = response;
      lectures.value = datalist;
      names.addAll(datalist.map((data) {
        return {
          'title': data['title'].toString(),
          'id': data['id'],
        };
      }));
    } catch(e) {
      print(e);
    }
  }

  Future<void> loadRutines() async {
    String jsonData = await rootBundle.loadString('assets/data/lecture/rutines.json');
    List<dynamic> dataList = jsonDecode(jsonData);
    rutines.assignAll(dataList.map((data) => data['title'].toString()));
  }

  List<int> recommendedLectures() {
    if(lectures.isEmpty || !isLoadingLectures.value) return <int>[];

    DateTime lastExecution = DateTime.fromMillisecondsSinceEpoch(_prefs.getInt('lastExecution') ?? 0);
    if (DateTime.now().difference(lastExecution).inDays >= 1) {
      
      _prefs.remove('recommendedLectures'); // Eliminamos las anteriores recomdnaciones
      
      List<int> selected = [];
      Random random = Random();
      int maxLectures = min(3, lectures.length); // ve cuantos elementos se pueden seleccion en base a la cantidad de lectures

      Set<int> historySet = (historyLectureController.currentHistoryLecture.lectures.map((e) => e as int)).toSet(); // historial de usuario

      while(selected.length < maxLectures) {
        int randomLecture = random.nextInt(lectures.length);
        if (!historySet.contains(randomLecture) && !selected.contains(randomLecture)) {
          logger.d("Numero agregado $randomLecture");
          selected.add(randomLecture);
        }
      }

      _prefs.setInt('lastExecution', DateTime.now().millisecondsSinceEpoch);
      _prefs.setStringList('recommendedLectures', selected.map((id) => id.toString()).toList());
      return selected;

    } else {
      List<int> results = _prefs.getStringList('recommendedLectures')?.map((id) => int.parse(id)).toList() ?? [];
      return results;
    }
  }


  List<ContentModel> getLecturesfromId(List<int> selected) {
    return selected.map((element) {
      return ContentModel.fromJson(lectures[element]);
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
        
        List<int> data =  recommendedLectures();
        recommended.value = getLecturesfromId(data);
        logger.d("recomended $recommended");
      } 
    } catch (e) {
      logger.e(e);
    }
  }


}