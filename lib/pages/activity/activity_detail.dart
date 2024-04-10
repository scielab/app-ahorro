import 'package:app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({super.key});

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {

  String title = "Consejos de Inversión para Principiantes";
  List<String> data = [
    "Comienza con lo básico: Antes de invertir, asegúrate de tener un fondo de emergencia y estar libre de deudas de alto interés.",
    "Diversifica tu cartera: No pongas todos tus huevos en una sola canasta. Invierte en una variedad de activos para reducir el riesgo.",
    "Aprende sobre los diferentes tipos de inversiones: Desde acciones y bonos hasta bienes raíces y fondos de inversión, hay muchas opciones disponibles. Dedica tiempo a comprender cada una.",
    "Establece metas financieras claras: Define tus objetivos de inversión a corto y largo plazo para ayudarte a tomar decisiones más informadas.",
    "Mantente informado: Lee libros, sigue blogs financieros, y mantente al tanto de las noticias económicas para tomar decisiones de inversión más sólidas.",
    "No te dejes llevar por las emociones: Evita tomar decisiones impulsivas basadas en el miedo o la codicia. Mantén la calma y toma decisiones racionales.",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SmallText(title:"Detalle de actividad"),
      ),
      body: Column(
        children: List.generate(data.length, (index) => Container(
          margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
          child: SmallText(title: data[index],
        )),
        ),
      ),
    );
  }
}