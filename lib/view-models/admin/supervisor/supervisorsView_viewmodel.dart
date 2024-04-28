import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class SupervisorsViewModel extends ChangeNotifier {
  bool loading = true;
  List<dynamic> supervisors = [];

  Future<void> getSupervisors(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetAllSupervisors',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        supervisors = data;
        supervisors = supervisors.toSet().toList();
        print(supervisors);
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loading = false;
      },
    );
  }
}
