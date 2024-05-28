import 'package:flutter/material.dart';
import 'package:industrial_watch/repositories/api_repo.dart';
import 'package:industrial_watch/utils/request_methods.dart';

class ViolationsViewModel extends ChangeNotifier {
  List<dynamic> violations = [];
  bool loading = true;

  Future<void> getViolations(BuildContext context, int employee_id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetAllViolations?employee_id=$employee_id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        violations = data;
        violations = violations.toSet().toList();
        print(violations);
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

  String getDummyImagePath(String rule) {
    String imagePath = 'assets/images/violations/';

    switch (rule.toLowerCase()) {
      case 'smoking':
        imagePath += 'smoking.jpg';
        break;
      case 'mobile usage':
        imagePath += 'mobile_usage.png';
        break;
      case 'sitting':
        imagePath += 'sitting.jpg';
        break;
      default:
        imagePath += 'default.png';
        break;
    }

    return imagePath;
  }
}
