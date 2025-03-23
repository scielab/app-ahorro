
enum ProfileCategory {
  unhealthyFinancialHabits,
  lackOfBudget,
  lackOfFinancialEducation,
  limitingMindset,
  lackOfKnowledge,
}

class QuestionModel {
  final String title;
  final List<String> alternatives;
  final String type;
  final List<ProfileCategory> seed;

  const QuestionModel({
    required this.title,
    required this.alternatives,
    this.type = "ALTERNATIVE",
    required this.seed,
  });  
}

