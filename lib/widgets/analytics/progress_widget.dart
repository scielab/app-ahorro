import 'package:app/utils/color_custom.dart';
import 'package:app/utils/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';



class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key});

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  final Color barColor = AppColors.contentColorWhite;
  final Color touchedBarColor = AppColors.contentColorGreen;
  final Color barBackgroundColor =AppColors.contentColorWhite.darken().withOpacity(0.2);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: BarChart(
        mainBarData(),
        //swapAnimationDuration: animDuration,
      ),
    );
  }

  List<Color> get availableColors => const <Color>[
        AppColors.contentColorRed,
        AppColors.contentColorGreen,
        AppColors.contentColorBlue,
      ];

  // Future<dynamic> refreshState() async {
  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 82,
    List<int> showTooltips = const [],
  }) {
    barColor ??= barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? touchedBarColor : barColor,
          width: width,
          borderRadius: BorderRadius.circular(15),
          borderSide: isTouched
              ? const BorderSide(color:  Color.fromARGB(255, 224, 224, 224))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 1500000,
            color: barBackgroundColor,
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
                weekDay = 'Gasto';
                break;
              case 1:
                weekDay = 'Ingreso';
                break;
              case 2:
                weekDay = 'Ahorro';
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
                  text: (rod.toY).toString(),
                  style: TextStyle(
                    color: touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          // setState(() {
          //   if (!event.isInterestedForInteractions ||
          //       barTouchResponse == null ||
          //       barTouchResponse.spot == null) {
          //     touchedIndex = -1;
          //     return;
          //   }
          //   touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          // });
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
        text = const Text('Gasto', style: style);
        break;
      case 1:
        text = const Text('Ingreso', style: style);
        break;
      case 2:
        text = const Text('Ahorro', style: style);
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

  List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              1000000,
              barColor: availableColors[0],
            );
          case 1:
            return makeGroupData(
              1,
              1200000,
              barColor: availableColors[1],
            );
          case 2:
            return makeGroupData(
              2,
              200000,
              barColor: availableColors[2],
            );
          default:
            return throw Error();
        }
      });
}