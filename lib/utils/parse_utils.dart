import 'package:intl/intl.dart';

enum NumberType { integer, double, none }

NumberType detectNumberType(String str) {
  try {
    int.parse(str);
    return NumberType.integer;
  } catch (_) {
  }
  
  try {
    double.parse(str);
    return NumberType.double;
  } catch (_) {
  }
  return NumberType.none;
}

num? convertToNumber(String str) {
  NumberType type = detectNumberType(str);
  
  switch (type) {
    case NumberType.integer:
      return int.parse(str);
    case NumberType.double:
      return double.parse(str); 
    case NumberType.none:
      return null;
  }
}


// parse value
String formatNumberEnglish(String number, {bool english = false}) {
  num? numberData = convertToNumber(number);
  if(numberData == null) return "";
  
  String locale = english ? 'en_US' : 'es_ES';
  final format = NumberFormat('#,##0', locale);
  String numeroFormateado = format.format(numberData);
  
  if (!english) {
    numeroFormateado = numeroFormateado.replaceAll(',', '.');
  }
  return numeroFormateado;
}
