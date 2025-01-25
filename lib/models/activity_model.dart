class ActivityModel {
  final String id;
  final String userId;
  final String type;
  final double carbonImpact;
  final DateTime timestamp;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.carbonImpact,
    required this.timestamp,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      carbonImpact: json['carbonImpact'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'carbonImpact': carbonImpact,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}