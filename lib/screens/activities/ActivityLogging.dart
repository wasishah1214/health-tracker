import 'package:flutter/material.dart';
import '../../providers/activity_provider.dart';

class LogActivityScreen extends StatefulWidget {
  @override
  _LogActivityScreenState createState() => _LogActivityScreenState();
}

class _LogActivityScreenState extends State<LogActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedActivity = 'walking';
  double _duration = 30;
  
  final Map<String, double> _carbonImpactPerHour = {
    'walking': 0,
    'cycling': 0,
    'public_transport': 0.14,
    'car': 2.3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Log Activity')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedActivity,
                decoration: InputDecoration(
                  labelText: 'Activity Type',
                  border: OutlineInputBorder(),
                ),
                items: _carbonImpactPerHour.keys.map((String activity) {
                  return DropdownMenuItem(
                    value: activity,
                    child: Text(activity.replaceAll('_', ' ').toUpperCase()),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() => _selectedActivity = value!);
                },
              ),
              SizedBox(height: 16),
              Slider(
                value: _duration,
                min: 5,
                max: 180,
                divisions: 35,
                label: '${_duration.round()} minutes',
                onChanged: (value) {
                  setState(() => _duration = value);
                },
              ),
              SizedBox(height: 24),
              Text(
                'Carbon Impact: ${_calculateCarbonImpact().toStringAsFixed(2)} kg CO₂',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text('Log Activity'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateCarbonImpact() {
    return _carbonImpactPerHour[_selectedActivity]! * (_duration / 60);
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Log activity logic here
    }
  }
}