class AppConstants {
  static const String appName = 'Eco Fitness Tracker';
  static const String appVersion = '1.0.0';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String activitiesCollection = 'activities';
  static const String challengesCollection = 'challenges';
  
  // Activity Types
  static const Map<String, double> carbonFactors = {
    'walking': 0.0,
    'cycling': 0.0,
    'bus': 0.089,
    'train': 0.041,
    'car': 0.171,
  };
}