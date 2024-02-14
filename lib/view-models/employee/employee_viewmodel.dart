import 'package:flutter/material.dart';

class EmployeeViewModel extends ChangeNotifier {
  void logout(context) {
    Navigator.of(context).pushReplacementNamed('/login');
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
