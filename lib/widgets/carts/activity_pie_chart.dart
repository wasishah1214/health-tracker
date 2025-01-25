import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ActivityPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: 40,
            title: 'Walking',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.blue,
            value: 30,
            title: 'Cycling',
            radius: 50,
          ),
          PieChartSectionData(
            color: Colors.orange,
            value: 30,
            title: 'Public Transit',
            radius: 50,
          ),
        ],
      ),
    );
  }
}