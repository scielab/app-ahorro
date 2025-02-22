
import 'package:app/models/question_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

