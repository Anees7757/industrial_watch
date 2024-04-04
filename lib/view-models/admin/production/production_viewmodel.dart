import 'package:flutter/material.dart';

class ProductionViewModel extends ChangeNotifier {
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
