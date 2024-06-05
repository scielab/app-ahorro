import 'package:intl/intl.dart';


String convertCompleteTimeToDate(String currentDate) {
  RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}');
  String? fecha = regex.stringMatch(currentDate);
  return fecha!;
}

DateTime parseDateString(String dateString) {
  var format = DateFormat("dd 'de' MMMM 'de' y, h:mm:ss a 'UTC'Z");  
  return format.parse(dateString);
}

String convertDateToFirestoreFormat(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date);
}