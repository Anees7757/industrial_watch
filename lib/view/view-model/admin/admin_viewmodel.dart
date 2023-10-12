import 'package:flutter/material.dart';

class AdminViewModel extends ChangeNotifier {

  void logout(context) {
    Navigator.of(context).pushReplacementNamed('/login');
    notifyListeners();
  }

  void navigate(context, String val) {
    if (val == 'section') {
      Navigator.of(context).pushNamed('/sections');
    } else if (val == 'supervisor') {
      Navigator.of(context).pushNamed('/supervisorsView');
    } else if (val == 'productivity') {
      Navigator.of(context).pushNamed('/employeeProductivity');
    } else {
      Navigator.of(context).pushNamed('/production');
    }

    notifyListeners();
  }
}
