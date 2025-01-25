import 'package:flutter/foundation.dart';
import '../models/challenge.dart';

class ChallengeProvider with ChangeNotifier {
  final List<Challenge> _challenges = [];
  final List<Challenge> _activeUserChallenges = [];

  List<Challenge> get challenges => List.unmodifiable(_challenges);
  List<Challenge> get activeUserChallenges => List.unmodifiable(_activeUserChallenges);

  void initializeChallenges() {
    _challenges.addAll([
      Challenge(
        title: 'Zero Emission Week',
        description: 'Keep your carbon emissions under 1 kg CO₂ per day',
        participants: 234,
        rewardPoints: 500,
      ),
      Challenge(
        title: 'Vegan Challenge',
        description: 'Eat only plant-based meals for 5 days',
        participants: 156,
        rewardPoints: 300,
      ),
    ]);
    notifyListeners();
  }

  void joinChallenge(Challenge challenge) {
    final existingChallenge = _challenges.firstWhere((c) => c.title == challenge.title);
    existingChallenge.isJoined = true;
    _activeUserChallenges.add(existingChallenge);
    notifyListeners();
  }

  void updateChallengeProgress(Challenge challenge, double progress) {
    final index = _activeUserChallenges.indexOf(challenge);
    if (index != -1) {
      _activeUserChallenges[index].progress = progress;
      notifyListeners();
    }
  }
}