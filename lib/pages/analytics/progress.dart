import 'dart:math';
import 'dart:ui';

import 'package:app/controllers/progress/progress_controller.dart';
import 'package:app/models/progress_model.dart';
import 'package:app/utils/color_custom.dart';
import 'package:app/utils/color_extensions.dart';
import 'package:app/utils/dimension.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:app/utils/size_widget.dart';
import 'package:app/widgets/base/charts/chartsWidget.dart';
import 'package:app/widgets/base/text/big_text.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/progress/progress_widget.dart';
import 'package:app/widgets/shopping_item.dart';
import 'package:app/widgets/base/text/small_text.dart';
import 'package:app/widgets/tag_result.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';

class ProgressPage extends StatefulWidget {
  ProgressPage({super.key});

  final Color barBackgroundColor =AppColors.contentColorWhite.darken().withOpacity(0.3);
  final Color barColor = AppColors.contentColorWhite;
  final Color touchedBarColor = AppColors.contentColorGreen;
  final ProgressController progressController = Get.find<ProgressController>();

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {

  bool loaderScreen = false;


  @override
  void initState() {
    //var budget = Get.find<BudgetController>().getBudgetRecentToFirebase;
    //budget.getBudgetRecentToFirebase();
    //refreshState();

    Future.delayed(const Duration(seconds: 1), () {
      loaderScreen = true;
      setState(() {
      });
    });

    super.initState();
  }

  String typeQuery = 'income';

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorPurple,
        AppColors.contentColorYellow,
        AppColors.contentColorBlue,
        AppColors.contentColorOrange,
        AppColors.contentColorPink,
        AppColors.contentColorRed,
        AppColors.contentColorGreen,
      ];
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;

  bool isPlaying = false;
  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              5,
              barColor: availableColors[0],
            );
          case 1:
            return makeGroupData(
              1,
              6.5,
              barColor: availableColors[1],
            );
          case 2:
            return makeGroupData(
              2,
              5,
              barColor: availableColors[2],
            );
          case 3:
            return makeGroupData(
              3,
              7.5,
              barColor: availableColors[3],
            );
          case 4:
            return makeGroupData(4, 9, barColor: availableColors[4]);
          case 5:
            return makeGroupData(
              5,
              11.5,
              barColor: availableColors[5],
            );
          case 6:
            return makeGroupData(
              6,
              6.5,
              barColor: availableColors[6],
            );
          default:
            return throw Error();
        }
      });

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );

    await refreshState();
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            switch (group.x) {
              case 0:
                weekDay = 'Monday';
                break;
              case 1:
                weekDay = 'Tuesday';
                break;
              case 2:
                weekDay = 'Wednesday';
                break;
              case 3:
                weekDay = 'Thursday';
                break;
              case 4:
                weekDay = 'Friday';
                break;
              case 5:
                weekDay = 'Saturday';
                break;
              case 6:
                weekDay = 'Sunday';
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('1', style: style);
        break;
      case 1:
        text = const Text('5', style: style);
        break;
      case 2:
        text = const Text('10', style: style);
        break;
      case 3:
        text = const Text('15', style: style);
        break;
      case 4:
        text = const Text('20', style: style);
        break;
      case 5:
        text = const Text('25', style: style);
        break;
      case 6:
        text = const Text('31', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }




  @override
  Widget build(BuildContext context) {
    return loaderScreen ?  Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Tu Progreso"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          typeQuery = types[1];
                        });
                      },
                      child: const ButtonBase(
                        title: "Gasto",
                        sizeWidget: SizeWidget.MID,
                        primary: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          typeQuery = types[0];
                        });
                      },
                      child: const ButtonBase(title: "Ingreso",sizeWidget: SizeWidget.MID,),
                    ),
                    //const ButtonBaseDrop(title: "June"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height * 0.25,
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: BarChart(
                  //     mainBarData(),
                  //     swapAnimationDuration: animDuration,
                  //   ),
                  // ),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(0, 3),
                            blurRadius: 7.0,
                            spreadRadius: 5,
                          ),
                        ],
                        color: AppColors.contentColorWhite,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(title: "Ingreso",size: Dimension.font16),
                          BigText(title: "CLP ${formatNumberEnglish(widget.progressController.getTotalAmmountMonh('income'))}",size: Dimension.font18,),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.contentColorWhite,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(0, 3),
                            blurRadius: 7.0,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(title: "Gasto",size: Dimension.font16),
                          BigText(title: "CLP ${formatNumberEnglish(widget.progressController.getTotalAmmountMonh('expense'))}",size: Dimension.font18,),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),            
                BigText(title: "Posible Ahorro del mes: CLP ${formatNumberEnglish(widget.progressController.getAllAmmount().toString())}",size: Dimension.font16,over: true),
                const SizedBox(height: 20,),            
                // Container(
                //   height: 250,
                //   padding: const EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     color: AppColors.contentColorWhite,
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.shade100,
                //         offset: const Offset(0, 3),
                //         blurRadius: 7.0,
                //         spreadRadius: 5,
                //       ),
                //     ]
                //   ),
                //   child: ChartsWidget(),
                // ),
                const SizedBox(height: 50,),            
                /*
                Center(
                  child: ProgressWidget(),
                ),
                */
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: FutureBuilder(
                      future: widget.progressController.getBudget(typeQuery),
                      initialData: null,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: AppColors.contentColorBlue,));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var analitics = widget.progressController.analytics;
                          return PieChart(PieChartData(
                              centerSpaceRadius: 30,
                              sectionsSpace: 10,
                              sections: List.generate(
                                analitics
                                    .length, // Aquí data es la lista de datos que deseas mostrar en el gráfico
                                (index) {
                                  return PieChartSectionData(
                                    value: analitics[index].totalPorcent,
                                    showTitle: true,
                                    radius: 70,
                                    titleStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimension.font20,
                                        fontWeight: FontWeight.bold),
                                    //color: availableColors[index % availableColors.length], // Esto se asegura de que los colores se repitan si hay más datos que colores disponibles
                                    color: widget.progressController
                                        .allCategories[index].color,
                                  );
                                },
                              )));
                        }
                      }),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Obx(() => TagResult(
                        title: "Día",
                        value:
                            formatNumberEnglish(widget.progressController.getTotalAmmountDay(typeQuery)))
                    ),
                    const Spacer(),
                    Obx(() => TagResult(
                        title: "Semana",
                        value: formatNumberEnglish(widget.progressController
                            .getTotalAmmountWeek(typeQuery)))
                    ),
                    const Spacer(),
                    Obx(() => TagResult(
                        title: "Mes",
                        value: formatNumberEnglish((widget.progressController.getTotalAmmountMonh(typeQuery)))
                    )),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                
                SizedBox(
                    child: FutureBuilder(
                        future: widget.progressController.getBudget(typeQuery),
                        initialData: null,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(color: AppColors.contentColorBlue,));
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            var analitics = widget.progressController.analytics;
                            return Column(
                              children: analitics.map((analytic) {
                                return ShoppingItem(
                                  title: analytic.category.name,
                                  category: typeQuery == 'income' ? "Ingreso" : "Gasto",
                                  value: formatNumberEnglish(analytic.totalAmmount.toString()),
                                  porcent: "${analytic.totalPorcent.toString()}\$",
                                  icon: analytic.category.icon,
                                  colorIcon: analytic.category.color,
                                );
                              }).toList(),
                            );
                          }
                        }),
                  ),
                
              ],
            ),
          ),
        ),
      ),
    ) : const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.contentColorBlue,),
      ),
    );
  }
}
