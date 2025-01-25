class Challenge {
  final String title;
  final String description;
  final int participants;
  final int rewardPoints;
  bool isJoined;
  double progress;

  Challenge({
    required this.title,
    required this.description,
    required this.participants,
    required this.rewardPoints,
    this.isJoined = false,
    this.progress = 0,
  });
}