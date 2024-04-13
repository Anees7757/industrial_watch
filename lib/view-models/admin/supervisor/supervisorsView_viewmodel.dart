import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class SupervisorsViewModel extends ChangeNotifier {
  bool loading = true;
  List<dynamic> supervisors = [];

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void edit(BuildContext context, int index) {
    if (index >= 0 && index < supervisors.length) {
      //   supervisors.forEach((key, value) {
      //     if (key == supervisors.keys.elementAt(index)) {
      //       print(supervisors[key]['username']);
      //       supervisors[key]['username'] = usernameController.text;
      //       supervisors[key]['password'] = passwordController.text;
      //     }
      //   });
    }
    usernameController.clear();
    passwordController.clear();
    Navigator.pop(context);
    notifyListeners();
  }

  void delete(BuildContext context, int index) {
    if (index >= 0 && index < supervisors.length) {
      // supervisors
      //     .removeWhere((key, value) => supervisors.keys.elementAt(index) == key);
      notifyListeners();
    }
  }

  void dialogCancel(BuildContext context) {
    usernameController.clear();
    passwordController.clear();
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future<void> getSupervisors(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Supervisor/get_all_supervisor',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        supervisors = data;
        supervisors = supervisors.toSet().toList();
        print(supervisors);
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loading = false;
      },
    );
  }
}
