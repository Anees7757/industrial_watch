import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

import '../../../../../repositories/api_repo.dart';
import '../../../../../utils/request_methods.dart';

class SummaryViewModel extends ChangeNotifier {
  String? fromSelectedDate;
  int? selectedMonth;
  int? selectedYear;
  // String toSelectedDate = '${DateTime.now().month} , ${DateTime.now().year}';

  Map<String, dynamic> summary = {};
  bool loading = true;

  Future<void> getSummary(BuildContext context, int employee_id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Employee/GetEmployeeSummary?employee_id=$employee_id&date=$fromSelectedDate',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        summary = data;
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        //customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }

  Future<void> showPicker(
      BuildContext context, String title, int employeeId) async {
    showMonthPicker(
      context,
      onSelected: (month, year) {
        print('Selected month: $month, year: $year');
        if (title == 'from') {
          fromSelectedDate = '$month,$year';
          selectedMonth = month;
          selectedYear = year;
          notifyListeners();
        } else {
          // toSelectedDate = '$month , $year';
        }
        getSummary(context, employeeId);
      },
      initialSelectedMonth: selectedMonth ?? DateTime.now().month,
      initialSelectedYear: selectedYear ?? DateTime.now().year,
      firstEnabledMonth: 1,
      lastEnabledMonth: DateTime.now().month,
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
