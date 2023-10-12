import 'package:flutter/material.dart';

class EmployeeViewModel extends ChangeNotifier{

  void logout(context){
    Navigator.of(context).pushReplacementNamed('/login');
    notifyListeners();
  }
}
