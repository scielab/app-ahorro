
import 'package:app/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
    // Preguntas relacionadas con los hábitos financieros poco saludables
    [10, 0, 0],  // ¿Tienes un presupuesto mensual que sigues?
    //[5, 0, 10],  // ¿Entiendes la diferencia entre activos y pasivos?
    [0, 0, 10],  // ¿Te sientes cómodo hablando de dinero con tu familia y amigos?
    // Preguntas relacionadas con la falta de presupuesto
    [5, 0, 10],   // ¿Sabes cómo calcular tu tasa de interés anual (APR) en una tarjeta de crédito?
    [0, 10, 5],   // ¿Tienes un plan para tu jubilación?

    // Preguntas relacionadas con la falta de educación financiera
    [0, 10, 5],   // ¿Sabes cómo proteger tu información financiera de fraudes y estafas?
    
    // Preguntas relacionadas con la mentalidad limitante
    [0, 0, 10],   // ¿Tienes un plan para tu jubilación?
    [10, 5, 0],   // ¿Te sientes cómodo hablando de dinero con tu familia y amigos?

 */

enum ProfileCategory {
  unhealthyFinancialHabits,
  lackOfBudget,
  lackOfFinancialEducation,
  limitingMindset,
  lackOfKnowledge,
}
class UserProfileManager {
  final List<QuestionModel> questions;
  final Map<ProfileCategory, int> scores = {
    ProfileCategory.unhealthyFinancialHabits: 0,
    ProfileCategory.lackOfBudget: 0,
    ProfileCategory.lackOfFinancialEducation: 0,
    ProfileCategory.limitingMindset: 0,
    ProfileCategory.lackOfKnowledge: 0,
  };
  final List<List<int>> answerScores = [
    [0, 0, 0, 0],  
    [10, 0, 0],  
    [0, 0, 10], 
    [5, 0, 10],   
    [0, 10, 5, 0],  
    [0, 10, 5],  
    [0, 0, 10],  
    [10, 5, 0],   
  ];
  UserProfileManager({
    required this.questions
  });

  void calculateAllScore(List<int> answers) {
    assert(answers.length == questions.length);
    print("Calculand para cada Question");
    for (int i = 0; i < questions.length; i++) {
      print("Question");
      calculateScore(questions[i], answers[i], i);
    }
  }

  void calculateScore(QuestionModel question, int answer,int index) {
    // se asigna exacatamento a todos los campos
    int value = answerScores[index][answer];
    for(int i=0;i<question.seed.length;i++) {
      ProfileCategory currentCategory = question.seed[i];
      int? currentScore = scores[currentCategory];
      if(currentScore != null) {
        print("Entro");
        scores[currentCategory] = currentScore + value;  
        print(scores);
      }
    }
  }

}
class UserProfileSegment {
  final Map<ProfileCategory, bool> categories;
  UserProfileSegment({
    required this.categories
  });
}

