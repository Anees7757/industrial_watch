import 'package:flutter/material.dart';

class EmployeeViewModel extends ChangeNotifier {
  void navigate(context, String val) {
    Navigator.of(context).pushNamed('/$val');
    notifyListeners();
  }
}
