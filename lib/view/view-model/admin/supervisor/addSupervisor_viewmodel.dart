import 'package:flutter/material.dart';
import 'package:industrial_watch/view/view-model/admin/supervisor/supervisorsView_viewmodel.dart';
import 'package:provider/provider.dart';

class AddSupervisorViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> selected = [];

  void createAccount(context) {
    SupervisorsViewModel supervisorsViewModel =
        Provider.of<SupervisorsViewModel>(context, listen: false);
    // Navigator.of(context).pushReplacementNamed('/login');
    Map<String, dynamic> user = {
      nameController.text: {
        'username': usernameController.text,
        'password': passwordController.text,
        'sections': selected
      },
    };
    supervisorsViewModel.supervisors.addAll(user);

    print(supervisorsViewModel.supervisors);

    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    selected.clear();

    Navigator.of(context).pop();
    notifyListeners();
  }

  dropDownOnChanged(List<String> x) {
    selected = x;
    notifyListeners();
  }
}
