
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String iduser;
  final String idCourse;
  final List<Lesson> lessonList;
  HistoryModel({required this.iduser,required this.idCourse, required this.lessonList});

  Map<String,dynamic> toMap() {
    return {
      'iduser': iduser,
      'idcourse': idCourse,
      'lessonlist': lessonList.map((lesson) => lesson.toMap()).toList(),
    };
  }
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    List<Lesson> lessonList = [];
    if (json['lessonlist'] != null) {
      lessonList = List<Lesson>.from(json['lessonlist'].map((lessonJson) =>
          Lesson.fromJson(lessonJson as Map<String, dynamic>)));
    }
    return HistoryModel(
      iduser: json['iduser'] as String,
      idCourse: json['idcourse'] as String,
      lessonList: lessonList,
    );
  }
  factory HistoryModel.fromQuery(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final Map<String, dynamic> json = snapshot.data();
    return HistoryModel.fromJson(json);
  }
}

class Lesson {
  final String idLesson;
  final bool completed;
  Lesson({required this.idLesson,required this.completed});

  Map<String,dynamic> toMap() {
    return {
      'idlesson': idLesson,
      'completed': completed
    };
  }
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(idLesson: json['idlesson'], completed: json['completed']);
  }
}


class HistoryLecture {
  final String iduser; 
  final List<dynamic> lectures;

  HistoryLecture({required this.iduser, required this.lectures});
  Map<String, dynamic> toMap() {
    return {
      'iduser': iduser,
      'lecturelist': lectures
    };
  }
  factory HistoryLecture.fromJson(Map<String, dynamic> json) {
    return HistoryLecture(iduser: json['iduser'], lectures: json['lecturelist']);
  }
}