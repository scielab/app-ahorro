
class Course {
  final int id;
  final String name;
  final List<Module> modules;
  Course({required this.id, required this.name, required this.modules});
  
  factory Course.fromJson(Map<String,dynamic> json) {
    // List<Module> modules = <Module>[];
    // for(var moduleJson in json['modules']) {
    //   modules.add(Module.fromJson(moduleJson));
    // }
    var moduleList = json['modules'] as List?;
    List<Module> modules = moduleList != null ? moduleList.map((moduleJson) => Module.fromJson(moduleJson)).toList() : <Module>[];
    return Course(id: json['id'], name: json['name'], modules: modules);
  }
}

class Module {
  final String lesson;
  final int id;
  final int n_lesson;
  final List<Entry> entries;

  Module({required this.id,required this.lesson, required this.n_lesson, required this.entries});

  factory Module.fromJson(Map<String,dynamic> json) {
    // List<Entry> moduleEntries = <Entry>[];
    // for(var entryJson in json['entries']) {
    //   if(entryJson['type'] == 'content') {
    //     moduleEntries.add(ContentEntry.fromJson(entryJson));
    //   } else {
    //     moduleEntries.add(QuestionEntry.fromJson(entryJson));
    //   }
    // }
    var entryList = json['entries'] as List?; // Maneja el caso null
    List<Entry> entriesData = entryList != null
        ? entryList.map((entryJson) {
            if (entryJson['type'] == 'content') {
              return ContentEntry.fromJson(entryJson);
            } else {
              return QuestionEntry.fromJson(entryJson);
            }
          }).toList()
        : <Entry>[];
    return Module(id: json['id'],lesson: json['lesson'], n_lesson: json['n_lesson'], entries: entriesData);
  }
}

abstract class Entry {
  final String type;
  final int id;
  Entry({required this.type, required this.id});
}


class ContentEntry extends Entry {
  final String title;
  final List<Content> content;
  final String imageUrl;

  ContentEntry({
    required String type,
    required int id,
    required this.title,
    required this.content,
    required this.imageUrl,
  }) : super(type: type, id: id);
  factory ContentEntry.fromJson(Map<String,dynamic> json) {
    var contentList = json['content'] as List?; // Maneja el caso null
    List<Content> contents = contentList != null
        ? contentList.map((contentJson) => Content.fromJson(contentJson)).toList()
        : <Content>[];

    return ContentEntry(
      type: json['type'], 
      id: json['id'], 
      title: json['title'], 
      content: contents,
      imageUrl: json['imageUrl'],
    );
  }
}

class Content {
  final int id;
  final String ctext;

  Content({required this.id, required this.ctext});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'],
      ctext: json['ctext'],
    );
  }
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

  factory QuestionEntry.fromJson(Map<String,dynamic> json) {
    // List<Option> questionOptions = <Option>[];
    // for(var optionJson in json['options']) {
    //   questionOptions.add(Option.fromJson(optionJson));
    // }
    var optionList = json['options'] as List?; // Maneja el caso null
    List<Option> questionOptions = optionList != null
        ? optionList.map((optionJson) => Option.fromJson(optionJson)).toList()
        : <Option>[];

    return QuestionEntry(
      type: json['type'], 
      id: json['id'], 
      contentId: json['contentid'], 
      question: json['question'], 
      options: questionOptions,
    );
  }
}


class Option {
  final int id;
  final String option;
  final bool isCorrect;
  Option({required this.id, required this.option, required this.isCorrect});
  factory Option.fromJson(Map<String,dynamic> json) {
    return Option(id: json['id'], option: json['option'], isCorrect: json['isCorrect']);
  }
}




