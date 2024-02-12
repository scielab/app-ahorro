

String convertCompleteTimeToDate(String currentDate) {
  RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}');
  String? fecha = regex.stringMatch(currentDate);
  return fecha!;
}
