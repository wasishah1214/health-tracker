import 'package:flutter/material.dart';
import '../services/carbon_calculation_service.dart';

class CarbonCalculator extends StatefulWidget {
  @override
  _CarbonCalculatorState createState() => _CarbonCalculatorState();
}

class _CarbonCalculatorState extends State<CarbonCalculator> {
  String _selectedActivity = 'walking';
  double _distance = 1.0;
  double _carbonSaved = 0.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedActivity,
              items: CarbonCalculationService.carbonFactors.keys
                  .map((activity) => DropdownMenuItem(
                        value: activity,
                        child: Text(activity.toUpperCase()),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedActivity = value!;
                  _updateCarbonSaved();
                });
              },
            ),
            SizedBox(height: 16),
            Slider(
              value: _distance,
              min: 1,
              max: 100,
              divisions: 99,
              label: '${_distance.round()} km',
              onChanged: (value) {
                setState(() {
                  _distance = value;
                  _updateCarbonSaved();
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Carbon Saved: ${_carbonSaved.toStringAsFixed(2)} kg CO₂',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  void _updateCarbonSaved() {
    _carbonSaved = CarbonCalculationService.calculateCarbonSaved(
      _selectedActivity,
      _distance,
    );
  }
}