import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';

class ActivityItem {
  final String id;
  final String name;
  final double carbonImpact;
  final String category;
  final String icon;
  final String description;

  const ActivityItem({
    required this.id,
    required this.name,
    required this.carbonImpact,
    required this.category,
    required this.icon,
    required this.description,
  });
}

class ActivityScreen extends StatelessWidget {
  static const List<ActivityItem> activities = [
    ActivityItem(
      id: '0',
      name: "Walking",
      carbonImpact: 0.5,
      category: 'transport',
      icon: '🚶',
      description: 'Walk instead of driving',
    ),
    ActivityItem(
      id: '1',
      name: "Car Trip (10km)",
      carbonImpact: 2.3,
      category: 'transport',
      icon: '🚗',
      description: 'Regular car journey',
    ),
    ActivityItem(
      id: '2',
      name: "Bus Trip (10km)",
      carbonImpact: 0.9,
      category: 'transport',
      icon: '🚌',
      description: 'Use public transport to reduce emissions',
    ),
    ActivityItem(
      id: '3',
      name: "Cycling (10km)",
      carbonImpact: 0,
      category: 'transport',
      icon: '🚲',
      description: 'Zero-emission transportation',
    ),
    ActivityItem(
      id: '4',
      name: "Meat-based Meal",
      carbonImpact: 3.5,
      category: 'food',
      icon: '🥩',
      description: 'High carbon impact meal choice',
    ),
    ActivityItem(
      id: '5',
      name: "Vegetarian Meal",
      carbonImpact: 1.2,
      category: 'food',
      icon: '🥗',
      description: 'Medium carbon impact meal choice',
    ),
    ActivityItem(
      id: '6',
      name: "Vegan Meal",
      carbonImpact: 0.7,
      category: 'food',
      icon: '🥬',
      description: 'Low carbon impact meal choice',
    ),
  ];

  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Activity'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Transport Activities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...activities
              .where((activity) => activity.category == 'transport')
              .map((activity) => _ActivityCard(
                    activity: activity,
                    onLog: () => _logActivity(context, activity),
                  )),
          const SizedBox(height: 24),
          const Text(
            'Food Activities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...activities
              .where((activity) => activity.category == 'food')
              .map((activity) => _ActivityCard(
                    activity: activity,
                    onLog: () => _logActivity(context, activity),
                  )),
        ],
      ),
    );
  }

  void _logActivity(BuildContext context, ActivityItem activity) {
    final activityProvider = Provider.of<ActivityProvider>(context, listen: false);
    activityProvider.addActivity(activity.name, activity.carbonImpact);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${activity.name} logged successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final ActivityItem activity;
  final VoidCallback onLog;

  const _ActivityCard({
    required this.activity,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  activity.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Carbon Impact: ${activity.carbonImpact} kg CO₂',
                        style: TextStyle(
                          color: activity.carbonImpact > 0 
                              ? Colors.red[700]
                              : Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onLog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('LOG ACTIVITY'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}