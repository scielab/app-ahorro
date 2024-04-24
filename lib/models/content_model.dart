
class ContentModel {
  final String title;
  final List<ContentPage> content;
  // fecha de creacion
  // decha de exposicion


  ContentModel({
    required this.title,
    required this.content,
  });
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
}

class TextModel {
  final String text;
  final String type; // text, math // arreglar en el futuro
  TextModel({required this.text, required this.type});
}
// Esto despues va a ser una lectura desde json

List<ContentModel> contents = [
  ContentModel(
    title: "Aprender los fundamentos de la inversion", 
    content: [
      ContentPage(
        title: "Aprender los fundamentos primero", 
        image: "'assets/images/notebook.png'", 
        contentText: [
          TextModel(text: "Comienza con lo básico: Antes de invertir, asegúrate de tener un fondo de emergencia y estar libre de deudas de alto interés.", type: 'text'),
          TextModel(text: "Diversifica tu cartera: No pongas todos tus huevos en una sola canasta. Invierte en una variedad de activos para reducir el riesgo.", type: 'text'),
        ]
      ),
      ContentPage(
        title: "Aprender los fundamentos primero", 
        image: "'assets/images/notebook.png'", 
        contentText: [
          TextModel(text: "Comienza con lo básico: Antes de invertir, asegúrate de tener un fondo de emergencia y estar libre de deudas de alto interés.", type: 'text'),
          TextModel(text: r'\hat f(\xi) = \int_{-\infty}^\infty f(x)e^{- 2\pi i \xi x}\mathrm{d}x', type: 'math'),
        ]
      ),
      ContentPage(
        title: "Aprender los fundamentos primero", 
        image: "'assets/images/notebook.png'", 
        contentText: [
          TextModel(text: "Comienza con lo básico: Antes de invertir, asegúrate de tener un fondo de emergencia y estar libre de deudas de alto interés.", type: 'text'),
          TextModel(text: "Diversifica tu cartera: No pongas todos tus huevos en una sola canasta. Invierte en una variedad de activos para reducir el riesgo.", type: 'text'),
        ]
      ),
    ]
  )
];


  // List<String> data = [
  //   "Comienza con lo básico: Antes de invertir, asegúrate de tener un fondo de emergencia y estar libre de deudas de alto interés.",
  //   "Diversifica tu cartera: No pongas todos tus huevos en una sola canasta. Invierte en una variedad de activos para reducir el riesgo.",
  //   "Aprende sobre los diferentes tipos de inversiones: Desde acciones y bonos hasta bienes raíces y fondos de inversión, hay muchas opciones disponibles. Dedica tiempo a comprender cada una.",
  //   "Establece metas financieras claras: Define tus objetivos de inversión a corto y largo plazo para ayudarte a tomar decisiones más informadas.",
  //   "Mantente informado: Lee libros, sigue blogs financieros, y mantente al tanto de las noticias económicas para tomar decisiones de inversión más sólidas.",
  //   "No te dejes llevar por las emociones: Evita tomar decisiones impulsivas basadas en el miedo o la codicia. Mantén la calma y toma decisiones racionales.",
  // ];

