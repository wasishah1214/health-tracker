class CarbonCalculationService {
  static const Map<String, double> carbonFactors = {
    'walking': 0.0,
    'cycling': 0.0,
    'bus': 0.089,
    'train': 0.041,
    'car': 0.171,
  };

  static double calculateCarbonSaved(String activity, double distance) {
    final carEmission = distance * carbonFactors['car']!;
    final activityEmission = distance * (carbonFactors[activity] ?? 0);
    return carEmission - activityEmission;
  }
}