import 'package:flutter/material.dart';

class SupervisorViewModel extends ChangeNotifier{

  void logout(context){
    Navigator.of(context).pushReplacementNamed('/login');
    notifyListeners();
  }
}