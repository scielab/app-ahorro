
abstract class Entry {
  final String type;
  final int id;
  Entry({required this.type, required this.id});
}
class ContentEntry extends Entry {
  final String title;
  final List<String> content;
  final String imageUrl;

  ContentEntry({
    required String type,
    required int id,
    required this.title,
    required this.content,
    required this.imageUrl,
  }) : super(type: type, id: id);

}

class QuestionEntry extends Entry {
  final int contentId;
  final String question;
  final List<Option> options;
  QuestionEntry({
    required String type,
    required int id,
    required this.contentId,
    required this.question,
    required this.options,
  }) : super(type: type, id: id);
}

class Option {
  final int id;
  final String option;
  final bool isCorrect;

  Option({required this.id, required this.option, required this.isCorrect});
}


// Future<void> loadJsonData(String filepath) async {
//   // var data = await File(filepath).readAsString();
//   // var jsonmap  = jsonDecode(data);
//   // print(jsonmap ['entries']);
  
  
//   String jsonData = await rootBundle.loadString('assets/data/content.json');
//   Map<String, dynamic> data = jsonDecode(jsonData);
//   //print(data);

//   final entries = (data['entries'] as List).map((entryJson) {
//     if (entryJson['type'] == 'content') {
//       return ContentEntry(
//         type: entryJson['type'],
//         id: entryJson['id'],
//         title: entryJson['title'],
//         content: List<String>.from(entryJson['content']),
//         imageUrl: entryJson['imageurl'],
//       );
//     } else if (entryJson['type'] == 'question') {
//       return QuestionEntry(
//         type: entryJson['type'],
//         id: entryJson['id'],
//         contentId: entryJson['contentid'],
//         question: entryJson['question'],
//         options: (entryJson['options'] as List).map((optionJson) {
//           return Option(
//             id: optionJson['id'],
//             option: optionJson['option'],
//             isCorrect: optionJson['isCorrect'],
//           );
//         }).toList(),
//       );
//     } else {
//       throw Exception('Tipo de entrada desconocido: ${entryJson['type']}');
//     }
//   }).toList();

//   print(entries);
// }



