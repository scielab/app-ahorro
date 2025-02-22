import 'dart:math';

import 'package:app/models/data/categories_models.dart';
import 'package:app/models/category_model.dart';


String generateNumberAvatar() {
  final random = Random();
  const letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final StringBuffer buffer = StringBuffer();

  for (int i = 0; i < 10; i++) {
    final letraAleatoria = letras[random.nextInt(letras.length)];
    buffer.write(letraAleatoria);
  }
  return buffer.toString();

}

Map<String,dynamic> searchIcon(int id,List<Map<String,dynamic>> category) {
  var data = category.firstWhere((e) => e['id'] == id);
  return data;
}