import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/challenge.dart';
import '../providers/challenge_provider.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize challenges after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final challengeProvider = Provider.of<ChallengeProvider>(context, listen: false);
      if (challengeProvider.challenges.isEmpty) {
        challengeProvider.initializeChallenges();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final challengeProvider = Provider.of<ChallengeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eco Challenges'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Eco Challenges',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your Active Challenges',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (challengeProvider.activeUserChallenges.isNotEmpty)
              ...challengeProvider.activeUserChallenges.map(
                (challenge) => ActiveChallengeCard(challenge: challenge),
              )
            else
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No active challenges. Join one below!'),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Available Challenges',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: challengeProvider.challenges.length,
                itemBuilder: (context, index) {
                  final challenge = challengeProvider.challenges[index];
                  return ChallengeCard(
                    challenge: challenge,
                    onJoin: () {
                      if (!challenge.isJoined) {
                        challengeProvider.joinChallenge(challenge);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Challenge joined successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveChallengeCard extends StatelessWidget {
  final Challenge challenge;

  const ActiveChallengeCard({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              challenge.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(challenge.description),
            const SizedBox(height: 8),
            Text('Progress: ${(challenge.progress * 100).toStringAsFixed(0)}%'),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: challenge.progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 8),
            Text('Reward: ${challenge.rewardPoints} points'),
          ],
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final Challenge challenge;
  final VoidCallback onJoin;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    required this.onJoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              challenge.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(challenge.description),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Participants: ${challenge.participants}'),
                Text('Reward: ${challenge.rewardPoints} points'),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: challenge.isJoined ? null : onJoin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: Text(challenge.isJoined ? 'JOINED' : 'JOIN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}