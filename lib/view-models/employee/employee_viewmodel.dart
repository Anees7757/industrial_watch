import 'package:flutter/material.dart';

import '../../utils/shared_prefs/shared_prefs.dart';

class EmployeeViewModel extends ChangeNotifier {
  void logout(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    DataSharedPrefrences.removeUser();
    notifyListeners();
  }

  void navigate(context, String val) {
    Navigator.of(context).pushNamed('/$val');
    // if (val == 'rules') {
    //   Navigator.of(context).pushNamed('/rules');
    // } else if (val == 'add_employee') {
    //   Navigator.of(context).pushNamed('/add_employee');
    // } else if(val == 'employee_record){
    // Navigator.of (context)
    // .pushNamed('/employee_record');
    // } else {
    // Navigator.of(context).pushNamed('/employee_ranking');
    // }

    notifyListeners();
  }
}
