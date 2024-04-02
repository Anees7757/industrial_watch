import 'package:flutter/material.dart';

import '../../utils/shared_prefs/shared_prefs.dart';

class SupervisorViewModel extends ChangeNotifier {
  void logout(context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    DataSharedPrefrences.removeUser();
    notifyListeners();
  }

  void navigate(context, String val) {
    Navigator.of(context).pushNamed('/$val');
    // if (val == 'section') {
    //   Navigator.of(context).pushNamed('/sections');
    // } else if (val == 'supervisor') {
    //   Navigator.of(context).pushNamed('/supervisorsView');
    // } else if (val == 'productivity') {
    //   Navigator.of(context).pushNamed('/employeeProductivity');
    // } else {
    //   Navigator.of(context).pushNamed('/production');
    // }

    notifyListeners();
  }
}
