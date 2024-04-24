
import 'package:get/get.dart';



class StatusUserController extends GetxController {

  Map<String, int> scores = {
    'Habitos financieros poco saludables': 8,
    'Falta de presupuesto': 16,
    'Falta de educacion financiera': 32,
    'Mentalidad relacionada con el dinero': 64,
  };
  List<int> userAnswers = [3, 2, 4, 1, 1, 3, 2, 4];

  void calculateProfile() {
    // Calcular la puntuación total para cada categoría basada en las respuestas del usuario
    for (int i = 0; i < userAnswers.length; i++) {
      //scores[scores.keys.elementAt(i)] += userAnswers[i];
    }

    // Obtener el perfil con la puntuación más alta
    String selectedProfile = scores.keys.first;
    scores.forEach((profile, score) {
      // if (score > scores[selectedProfile]) {
      //   selectedProfile = profile;
      // }
    });
  }

}