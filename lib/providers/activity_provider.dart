import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Activity {
  final String type;
  final DateTime time;
  final double impact;
  final String? note;

  Activity({
    required this.type,
    required this.time,
    required this.impact,
    this.note,
  });
}

class ActivityProvider with ChangeNotifier {
  final List<Activity> _activities = [];
  final double _dailyGoal = 5.0; // 5kg CO2 reduction per day

  List<Activity> get activities => List.unmodifiable(_activities);
  
  List<Activity> get todaysActivities {
    final now = DateTime.now();
    return _activities.where((activity) {
      return DateFormat('yyyy-MM-dd').format(activity.time) ==
          DateFormat('yyyy-MM-dd').format(now);
    }).toList();
  }

  List<Activity> get recentActivities {
    final sortedActivities = List<Activity>.from(_activities)
      ..sort((a, b) => b.time.compareTo(a.time));
    return sortedActivities.take(10).toList();
  }

  double get todaysTotalImpact {
    return todaysActivities.fold(
      0,
      (sum, activity) => sum + activity.impact,
    );
  }

  double getImpactForDate(DateTime date) {
    final activities = _activities.where((activity) {
      return DateFormat('yyyy-MM-dd').format(activity.time) ==
          DateFormat('yyyy-MM-dd').format(date);
    }).toList();

    return activities.fold(
      0,
      (sum, activity) => sum + activity.impact,
    );
  }

  void addActivity(String type, double impact, {String? note}) {
    _activities.add(
      Activity(
        type: type,
        time: DateTime.now(),
        impact: impact,
        note: note,
      ),
    );
    notifyListeners();
  }

  double get dailyGoal => _dailyGoal;

  bool get hasTodaysMeasurement {
    final now = DateTime.now();
    return _activities.any((activity) {
      return DateFormat('yyyy-MM-dd').format(activity.time) ==
          DateFormat('yyyy-MM-dd').format(now);
    });
  }

  // Sample activities for testing
  void addSampleActivities() {
    final now = DateTime.now();
    
    // Add activities for the last 6 days
    for (int i = 5; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      
      // Morning walk
      _activities.add(Activity(
        type: 'walking',
        time: DateTime(date.year, date.month, date.day, 8, 0),
        impact: 0.5 + (i % 3) * 0.2, // Varying impact
      ));

      // Evening cycling
      if (i % 2 == 0) { // Add cycling every other day
        _activities.add(Activity(
          type: 'cycling',
          time: DateTime(date.year, date.month, date.day, 17, 30),
          impact: 1.2 + (i % 2) * 0.3,
        ));
      }
    }
    
    notifyListeners();
  }

  // Clear all activities (useful for testing or user logout)
  void clearActivities() {
    _activities.clear();
    notifyListeners();
  }
}