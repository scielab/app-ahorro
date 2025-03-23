
import 'package:app/models/question_model.dart';

List<QuestionModel> questions_data = const [
  QuestionModel(
    title: "¿Cuál es tu grupo de edad?",
    alternatives: [
      "18-24 años",
      "25-35 años",
      "36-54 años",
      "Mayor de 55 años",
    ],
    seed: [ProfileCategory.limitingMindset],
  ),
  QuestionModel(
    title: "¿Utilizas algún método o sistema para gestionar tus finanzas personales?",
    alternatives: [
      "Sí, utilizo un presupuesto regularmente",
      "Sí, a veces uso un presupuesto",
      "No, no utilizo ningún presupuesto",
    ],
    seed: [ProfileCategory.lackOfBudget, ProfileCategory.lackOfFinancialEducation]
  ),
  QuestionModel(
    title: "¿Qué tan familiarizado estás con los conceptos básicos de educación financiera?",
    alternatives: [
      "Muy familiarizado",
      "Algo familiarizado",
      "No estoy familiarizado",
    ],
    seed: [ProfileCategory.lackOfBudget, ProfileCategory.lackOfFinancialEducation,ProfileCategory.lackOfKnowledge]
  ),
  QuestionModel(
    title: "¿Cuál es tu mayor área de gasto habitual en tu día a día?",
    alternatives: [
      "Alimentación",
      "Transporte",
      "Entretenimiento",
    ],
    seed: [ProfileCategory.unhealthyFinancialHabits, ProfileCategory.lackOfFinancialEducation]
  ),
  QuestionModel(
    title: "¿Qué tanto te preocupa la inflación y su impacto en tu economía personal?",
    alternatives: [
      "Muy preocupado",
      "Algo preocupado",
      "No estoy seguro",
      "No me preocupa",
    ],
    seed: [ProfileCategory.lackOfKnowledge, ProfileCategory.lackOfFinancialEducation]

  ),
  QuestionModel(
    title: "¿Has solicitado algún crédito en el pasado?",
    alternatives: [
      "Sí, varias veces",
      "Sí, una vez",
      "No, nunca he solicitado crédito",
    ],
    seed: [ProfileCategory.lackOfKnowledge, ProfileCategory.lackOfFinancialEducation]
  ),
  QuestionModel(
    title: "¿Cómo describirías tu relación emocional con el dinero?",
    alternatives: [
      "Suelo preocuparme por el dinero y trato de administrarlo cuidadosamente",
      "A veces me siento ansioso respecto al dinero pero no siempre tomo decisiones financieras acertadas",
      "No suelo preocuparme mucho por el dinero y gasto sin pensar en las consecuencias",
    ],
    seed: [ProfileCategory.lackOfKnowledge, ProfileCategory.limitingMindset]
  ),
  QuestionModel(
    title: "¿Tienes un plan para tu jubilación?",
    alternatives: [
      "Sí, tengo un plan de inversiones a largo plazo.",
      "No tengo un plan formal, pero estoy ahorrando.",
      "No he pensado en la jubilación todavía.",
    ],
    seed: [ProfileCategory.lackOfKnowledge, ProfileCategory.lackOfFinancialEducation]
  ),
];