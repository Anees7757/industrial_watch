import 'package:flutter/material.dart';

import '../../../views/screens/admin/production/batch/batchDetails_screen.dart';

class ProductionViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  Map<String, dynamic> batches = {
    'Batch#11320051123': [
      'P#110212323',
      'P#110111523',
    ],
    'Batch#11302021123': [
      'P#110212323',
      'P#110111523',
    ],
    'Batch#11313121123': [
      'P#110212323',
      'P#110111523',
    ],
  };

  Map<String, dynamic> filteredBatches = {};

  void search(BuildContext context, String query) {
    filteredBatches.clear();

    if (query.isNotEmpty) {
      filteredBatches = {
        for (var entry in batches.entries)
          if (entry.key.split('#')[1].contains(query)) entry.key: entry.value,
      };
    }

    print(filteredBatches);

    notifyListeners();
  }

  navigate(BuildContext context, String key) {
    Map<String, dynamic> batch = {key: batches[key]};
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BatchDetailsScreen(batch: batch)));
    notifyListeners();
  }

  clear() {
    searchController.clear();
    filteredBatches.clear();
    notifyListeners();
  }
}
