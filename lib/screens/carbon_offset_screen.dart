import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carbon_offset_provider.dart';
import '../providers/activity_provider.dart';

class CarbonOffsetScreen extends StatelessWidget {
  static const List<OffsetOption> offsetOptions = [
    OffsetOption(
      title: 'Plant Trees',
      description: 'Support tree planting initiatives',
      costPerKg: 2.5,
      icon: '🌳',
    ),
    OffsetOption(
      title: 'Solar Energy Projects',
      description: 'Fund solar energy installations',
      costPerKg: 3.0,
      icon: '☀️',
    ),
    OffsetOption(
      title: 'Wind Energy',
      description: 'Support wind farm development',
      costPerKg: 2.8,
      icon: '💨',
    ),
  ];

  const CarbonOffsetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offsetProvider = Provider.of<CarbonOffsetProvider>(context);
    final activityProvider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offset Carbon'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarbonSummaryCard(
                totalEmissions: activityProvider.todaysTotalImpact,
                offsetAmount: offsetProvider.totalOffset,
              ),
              const SizedBox(height: 24),
              const Text(
                'Offset Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...offsetOptions.map(
                (option) => OffsetOptionCard(
                  option: option,
                  onOffset: () {
                    _showOffsetDialog(context, option, offsetProvider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOffsetDialog(
    BuildContext context,
    OffsetOption option,
    CarbonOffsetProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => OffsetDialog(option: option, provider: provider),
    );
  }
}

class OffsetOption {
  final String title;
  final String description;
  final double costPerKg;
  final String icon;

  const OffsetOption({
    required this.title,
    required this.description,
    required this.costPerKg,
    required this.icon,
  });
}

class CarbonSummaryCard extends StatelessWidget {
  final double totalEmissions;
  final double offsetAmount;

  const CarbonSummaryCard({
    Key? key,
    required this.totalEmissions,
    required this.offsetAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Carbon Footprint',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Emissions'),
                    Text(
                      '${totalEmissions.toStringAsFixed(2)} kg CO₂',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Offset Amount'),
                    Text(
                      '${offsetAmount.toStringAsFixed(2)} kg CO₂',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OffsetDialog extends StatefulWidget {
  final OffsetOption option;
  final CarbonOffsetProvider provider;

  const OffsetDialog({
    Key? key,
    required this.option,
    required this.provider,
  }) : super(key: key);

  @override
  State<OffsetDialog> createState() => _OffsetDialogState();
}

class _OffsetDialogState extends State<OffsetDialog> {
  double amount = 1.0;

  @override
  Widget build(BuildContext context) {
    final totalCost = amount * widget.option.costPerKg;

    return AlertDialog(
      title: Text('Offset with ${widget.option.title}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select amount to offset:'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: amount,
                  min: 0.1,
                  max: 10.0,
                  divisions: 99,
                  label: '${amount.toStringAsFixed(1)} kg',
                  onChanged: (value) => setState(() => amount = value),
                ),
              ),
              Text('${amount.toStringAsFixed(1)} kg'),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Total Cost: \$${totalCost.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.provider.addOffset(
              OffsetTransaction(
                date: DateTime.now(),
                method: widget.option.title,
                amount: amount,
                cost: totalCost,
              ),
            );
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Carbon offset successful!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }
}

class OffsetOptionCard extends StatelessWidget {
  final OffsetOption option;
  final VoidCallback onOffset;

  const OffsetOptionCard({
    Key? key,
    required this.option,
    required this.onOffset,
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
            Row(
              children: [
                Text(
                  option.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(option.description),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cost: \$${option.costPerKg}/kg CO₂'),
                ElevatedButton(
                  onPressed: onOffset,
                  child: const Text('OFFSET NOW'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}