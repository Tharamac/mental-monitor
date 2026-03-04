import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final double minX;
  final double maxX;
  LineChartWidget(this.minX, this.maxX);
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
    7,
    9,
    8,
    9,
    7,
    0
  ];

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0,
          maxY: 10,
          // titlesData: LineTitles.getTitleData(),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff37434d),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineTouchData: LineTouchData(
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
              spots: List.generate(30,
                  (index) => FlSpot(index.toDouble(), score[index].toDouble())),
              // isCurved: true,
              color: gradientColors[0],
              barWidth: 5,
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
}
