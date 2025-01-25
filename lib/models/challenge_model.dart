class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final double carbonGoal;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participants;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.carbonGoal,
    required this.startDate,
    required this.endDate,
    this.participants = const [],
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      carbonGoal: json['carbonGoal'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      participants: List<String>.from(json['participants'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'carbonGoal': carbonGoal,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'participants': participants,
  };
}