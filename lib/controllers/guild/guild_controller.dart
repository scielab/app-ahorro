import 'dart:convert';
import 'package:app/models/guild_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class GuildController extends GetxController {

  RxList<List<Entry>> _datalist = <List<Entry>>[[]].obs;
  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  RxList<List<Entry>> get datalist => _datalist;
  


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadJsonData() async {    
    String jsonData = await rootBundle.loadString('assets/data/content.json');
    List<dynamic> dataList  = jsonDecode(jsonData);
    
    List<List<Entry>> groupedEntries = [];

    for (var data in dataList) {
      final entries = (data['entries'] as List).map((entryJson) {
        if (entryJson['type'] == 'content') {
          return ContentEntry(
            type: entryJson['type'],
            id: entryJson['id'],
            title: entryJson['title'],
            content: List<String>.from(entryJson['content']),
            imageUrl: entryJson['imageurl'],
          );
        } else if (entryJson['type'] == 'question') {
          return QuestionEntry(
            type: entryJson['type'],
            id: entryJson['id'],
            contentId: entryJson['contentid'],
            question: entryJson['question'],
            options: (entryJson['options'] as List).map((optionJson) {
              return Option(
                id: optionJson['id'],
                option: optionJson['option'],
                isCorrect: optionJson['isCorrect'],
              );
            }).toList(),
          );
        } else {
          throw Exception('Tipo de entrada desconocido: ${entryJson['type']}');
        }
      }).toList();
      groupedEntries.add(entries);
    }
    print("Mostrando el size del array");
    print(groupedEntries.length);
    if(groupedEntries.isNotEmpty) {
      _isLoading.value = true;
      _datalist.value = groupedEntries;
    } else {
      print("Error lanzar una excepcion aqui");
    }

  }

}