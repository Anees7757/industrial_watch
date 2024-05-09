import 'package:flutter/material.dart';
import 'package:industrial_watch/repositories/api_repo.dart';
import 'package:industrial_watch/utils/request_methods.dart';

class EmployeeDetailViewModel extends ChangeNotifier {
  Map<String, dynamic> employee = {};

  bool loading = true;

  Future<void> getEmployee(BuildContext context, int employee_id) async {
    loading = true;
    employee.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetEmployeeDetail?employee_id=$employee_id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        employee = data;
        print("Employee >>>>> " + employee.toString());
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loading = false;
        notifyListeners();
      },
    );
  }
}
