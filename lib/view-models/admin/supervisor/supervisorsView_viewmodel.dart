import 'package:flutter/material.dart';

class SupervisorsViewModel extends ChangeNotifier {
  Map<String, dynamic> supervisors = {
    'Anwar Ali': {
      'username': 'anwar263',
      'password': 'anwar123',
      'sections': [
        'Management'
      ],
    },
    'Muhammad Ali': {
      'username': 'ali87',
      'password': 'ali123',
      'sections': [
        'Packing'
      ],
    },
    'Umer Shehzad': {
      'username': 'umer237',
      'password': 'umer123',
      'sections': [
        'Manufacturing'
      ],
    },
  };

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void edit(BuildContext context, int index) {
    if (index >= 0 && index < supervisors.length) {
      supervisors.forEach((key, value) {
        if (key == supervisors.keys.elementAt(index)) {
          print(supervisors[key]['username']);
          supervisors[key]['username'] = usernameController.text;
          supervisors[key]['password'] = passwordController.text;
        }
      });
    }
    usernameController.clear();
    passwordController.clear();
    Navigator.pop(context);
    notifyListeners();
  }

  void delete(BuildContext context, int index) {
    if (index >= 0 && index < supervisors.length) {
      supervisors
          .removeWhere((key, value) => supervisors.keys.elementAt(index) == key);
      notifyListeners();
    }
  }

  void dialogCancel(BuildContext context){
    usernameController.clear();
    passwordController.clear();
    Navigator.of(context).pop();
    notifyListeners();
  }
}