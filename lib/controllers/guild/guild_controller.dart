import 'dart:convert';
import 'package:app/controllers/history/history_controller.dart';
import 'package:app/models/guild_model.dart';
import 'package:app/models/history_model.dart';
import 'package:app/service/repository/guild_repo.dart';
import 'package:app/utils/app_debug_reports.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class GuildController extends GetxController {

  final GuildRepo guildRepo;

  GuildController({required this.guildRepo});


  RxList<List<Entry>> _datalist = <List<Entry>>[[]].obs;
  RxBool _isLoading = false.obs;
  RxBool _isLoadingModule = false.obs;
  RxBool _isLoadingDetail = false.obs;
  late Course? currentCourse;
  RxList listcourses = <Course>[].obs;

  bool get isLoading => _isLoading.value;
  bool get isLoadingDetail => _isLoadingDetail.value;
  bool get isLoadingModule => _isLoadingModule.value;
  RxList<List<Entry>> get datalist => _datalist;

  late HistoryController historyController;
  RxBool isLoadingCurrentHistory = false.obs;


  @override
  void onInit() {
    historyController = Get.find<HistoryController>();
    super.onInit();
  }
  
  Future<void> getDataNamesGuilds() async {
    try {
      final response = await guildRepo.getGuild();
      List<dynamic> datalist = response;
      listcourses.clear();
      for(var item in datalist) {
        listcourses.add(Course.fromJson(item));
      }
      _isLoading.value = true;
    } catch (e) {
      print(e);
    }
  }


  Future<void> getDataModuleCourse(int idcourse) async {
    try {
      Map<String,dynamic> datalist = await guildRepo.getGuild(idcourse);
      if (datalist != null) {
        currentCourse = Course.fromJson(datalist);
        _isLoadingModule.value = true;
      } else {
        currentCourse = null; 
      }
    } catch (e) {
      currentCourse = null;
      logger.e("Error al cargar el curso");
    } 

  }

  Future<void> existHistoryDetailCourse(String idUser, String idCourse) async {
    try {
      if(idUser.isEmpty || idCourse.isEmpty) {
        throw Exception("Alguno de los campos idUser o idCourse con vacios");
      }
      var history = await historyController.getHistoryModel(idUser,idCourse);
      if(history == null) {
        HistoryModel historyModel = HistoryModel(iduser: idUser, idCourse: idCourse, lessonList: []);
        await historyController.createHistoryModel(historyModel);
        historyController.setHistoryModel(historyModel);
        isLoadingCurrentHistory.value = true;
      } else {
        historyController.setHistoryModel(history);
        isLoadingCurrentHistory.value = true;
        print("Guardando el elemento de history controller");
      }
    } catch (e) {
      logger.e(e);
    }
  }
  
  Future<void> finishLessonHistory(String uidlesson) async {
    try {
      if(uidlesson.isEmpty) throw Exception("El campo id de lesson es vacio");
      historyController.updateLesson(Lesson(idLesson: uidlesson, completed: true));
    } catch(e) {
      logger.e(e);
    }
  }

}