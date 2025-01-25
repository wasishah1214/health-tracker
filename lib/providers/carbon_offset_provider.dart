import 'package:flutter/foundation.dart';

class CarbonOffsetProvider with ChangeNotifier {
  final List<OffsetTransaction> _offsetHistory = [];
  double _totalOffset = 0.0;

  List<OffsetTransaction> get offsetHistory => List.unmodifiable(_offsetHistory);
  double get totalOffset => _totalOffset;

  void addOffset(OffsetTransaction transaction) {
    _offsetHistory.insert(0, transaction);
    _totalOffset += transaction.amount;
    notifyListeners();
  }
}

class OffsetTransaction {
  final DateTime date;
  final String method;
  final double amount;
  final double cost;

  OffsetTransaction({
    required this.date,
    required this.method,
    required this.amount,
    required this.cost,
  });
}