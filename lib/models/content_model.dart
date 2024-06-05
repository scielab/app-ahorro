
class ContentModel {
  final String title;
  final int id;
  final List<ContentPage> content;
  ContentModel({
    required this.id,
    required this.title,
    required this.content,
  });
  factory ContentModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> contentPages = json['content'];
    List<ContentPage> contentList = contentPages
        .map((pageJson) => ContentPage.fromJson(pageJson))
        .toList();

    return ContentModel(
      title: json['title'],
      id: json['id'],
      content: contentList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content.map((page) => page.toJson()).toList(),
    };
  }
}

class ContentPage {
  final String title;
  final String image;
  final List<TextModel> contentText;
  ContentPage({
    required this.title,
    required this.image,
    required this.contentText
  });
  factory ContentPage.fromJson(Map<String, dynamic> json) {
    List<dynamic> textModels = json['contentText'];
    List<TextModel> textList =
        textModels.map((textJson) => TextModel.fromJson(textJson)).toList();

    return ContentPage(
      title: json['title'],
      image: json['image'],
      contentText: textList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'contentText': contentText.map((textModel) => textModel.toJson()).toList(),
    };
  }
}
class TextModel {
  final String text;
  final String type; // text, math // arreglar en el futuro
  TextModel({required this.text, required this.type});

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      text: json['text'],
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'type': type,
    };
  }
}

