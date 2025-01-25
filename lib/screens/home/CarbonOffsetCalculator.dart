import 'package:flutter/material.dart';
import '../../widgets/carbon_calculator.dart';

class OffsetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carbon Offset')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculate Your Carbon Footprint',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            CarbonCalculator(),
          ],
        ),
      ),
    );
  }
}