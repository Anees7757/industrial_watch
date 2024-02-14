import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

class EmployeeSummaryViewModel extends ChangeNotifier {
  String fromSelectedDate =
      '${DateTime.now().month - 1} , ${DateTime.now().year}';
  String toSelectedDate = '${DateTime.now().month} , ${DateTime.now().year}';

  Future<void> showPicker(BuildContext context, String title) async {
    showMonthPicker(
      context,
      onSelected: (month, year) {
        print('Selected month: $month, year: $year');
        if (title == 'from') {
          fromSelectedDate = '$month , $year';
        } else {
          toSelectedDate = '$month , $year';
        }
        notifyListeners();
      },
      initialSelectedMonth: DateTime.now().month,
      initialSelectedYear: DateTime.now().year,
      firstEnabledMonth: 3,
      lastEnabledMonth: 10,
      firstYear: 2020,
      lastYear: DateTime.now().year,
      selectButtonText: 'OK',
      cancelButtonText: 'Cancel',
      highlightColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      contentBackgroundColor: Colors.grey.shade100,
      dialogBackgroundColor: Colors.grey.shade100,
    );
  }
}
