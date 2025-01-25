import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CarbonLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2, 2),
              FlSpot(4, 5),
              FlSpot(6, 3.1),
              FlSpot(8, 4),
              FlSpot(10, 3),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}