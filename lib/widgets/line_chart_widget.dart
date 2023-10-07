import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_monitor/model/core/datetime_expansion.dart';
import 'package:mental_monitor/util.dart';

class LineChartWidget extends StatelessWidget {
  final double minX;
  final double maxX;
  final Map<DateTime, int>? data;
  LineChartWidget(this.minX, this.maxX, {this.data});
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  final score = [
    3,
    5,
    4,
    5,
    6,
    6,
    9,
    6,
    5,
    6,
    7,
    4,
    7,
    5,
    6,
    8,
    6,
    7,
    8,
    7,
    6,
    5,
    9,
    8,
    10,
    9,
    8,
    9,
    7,
    6,
    8
  ];

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0,
          maxY: 10,
          titlesData: FlTitlesData(
              topTitles: AxisTitles(axisNameWidget: const SizedBox.shrink()),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 1,
                getTitlesWidget: bottomTitleWidgets,
              ))),
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Color.fromARGB(255, 167, 169, 171),
                  strokeWidth: 0.5,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Color.fromARGB(255, 167, 169, 171),
                  strokeWidth: 0.5,
                );
              },
              horizontalInterval: 1),
          rangeAnnotations: RangeAnnotations(),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.blue[100],
              tooltipPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final today = DateTime.now().dateOnly;
                  final flSpot = barSpot;

                  return LineTooltipItem(
                    '${formatShortBuddhismYear(today.subtract(Duration(days: 29 - flSpot.x.toInt())))}\n',
                    TextStyle(
                        // fontStyle: FontStyle.italic,
                        // fontWeight: FontWeight.w900,
                        ),
                    children: [
                      // const TextSpan(
                      //   text: 'ระดับ ',
                      //   style: TextStyle(
                      //       // fontStyle: FontStyle.italic,
                      //       height: 1),
                      // ),
                      TextSpan(
                        text: "${flSpot.y.toInt()}",
                        style: GoogleFonts.ibmPlexSansThai(
                          fontSize: 24,
                          // color: Colors.black,
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                        ),
                        // TextStyle(
                        //   // color: widget.tooltipTextColor,
                        //   height: 1,
                        //   fontSize: 24,
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
            touchCallback: (event, response) {
              if (response?.lineBarSpots != null && event is FlTapUpEvent) {
                print(response?.lineBarSpots?.first.y);
                // setState(() {
                //   final spotIndex = response?.lineBarSpots?[0].spotIndex ?? -1;
                //   if(spotIndex == showingTooltipSpot) {
                //     showingTooltipSpot = -1;
                //   }
                //   else {
                //     showingTooltipSpot = spotIndex;
                //   }
                // });
              }
            },
          ),
          lineBarsData: [
            LineChartBarData(
              spots: (data != null)
                  ? data!.entries.map((e) {
                      return FlSpot(
                          data!.length -
                              (DateTime.now()
                                  .dateOnly
                                  .difference(e.key)
                                  .inDays
                                  .toDouble()),
                          e.value.toDouble());
                    }).toList()
                  : List.generate(
                      30,
                      (index) =>
                          FlSpot(index.toDouble(), score[index].toDouble())),
              // isCurved: true,
              color: gradientColors[0],
              barWidth: 1,
              // dotData: FlDotData(show: false),
              // belowBarData: BarAreaData(
              //   show: true,
              //   color: gradientColors
              //       .map((color) => color.withOpacity(0.3))
              //       .toList()[0],
              // ),
            ),
          ],
        ),
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    final today = DateTime.now().dateOnly;

    return SideTitleWidget(
      axisSide: AxisSide.right,
      space: 5,
      angle: pi / 2,
      child: Text(
        formatShortBuddhismYear(
            today.subtract(Duration(days: data!.length - value.toInt()))),
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }
}
