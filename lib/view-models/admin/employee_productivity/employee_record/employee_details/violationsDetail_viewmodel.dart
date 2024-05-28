import 'package:flutter/material.dart';
import 'package:industrial_watch/repositories/api_repo.dart';
import 'package:industrial_watch/utils/request_methods.dart';

class ViolationsDetailViewModel extends ChangeNotifier {
  Map<String, dynamic> violations = {};
  bool loading = true;

  Future<void> getViolationsDetail(
      BuildContext context, int violation_id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetViolationDetails?violation_id=$violation_id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        violations = data;
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
