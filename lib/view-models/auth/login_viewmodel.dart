import 'package:flutter/material.dart';

import '../../views/widgets/custom_snackbar.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(BuildContext context) {
    if (emailController.text.trim() != "" &&
        passwordController.text.trim() != "") {
      String email = emailController.text.trim();

      switch (email) {
        case 'admin':
          Navigator.of(context).pushReplacementNamed('/admin');
          customSnackBar(context, 'Login Successful');

          emailController.clear();
          passwordController.clear();
          break;
        case 'supervisor':
          Navigator.of(context).pushReplacementNamed('/supervisor');
          customSnackBar(context, 'Login Successful');

          emailController.clear();
          passwordController.clear();
          break;
        case 'employee':
          customSnackBar(context, 'Login Successful');
          Navigator.of(context).pushReplacementNamed('/employee');

          emailController.clear();
          passwordController.clear();
          break;
        default:
          customSnackBar(context, 'Wrong Credentials');
      }
    } else {
      customSnackBar(context, 'All field must be filled');
    }

    notifyListeners();
  }
}
