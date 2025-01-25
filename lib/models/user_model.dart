class UserModel {
  final String id;
  final String name;
  final String email;
  double totalCarbonSaved;
  List<String> completedChallenges;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.totalCarbonSaved = 0.0,
    this.completedChallenges = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      totalCarbonSaved: json['totalCarbonSaved'] ?? 0.0,
      completedChallenges: List<String>.from(json['completedChallenges'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'totalCarbonSaved': totalCarbonSaved,
      'completedChallenges': completedChallenges,
    };
  }
}