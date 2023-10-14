import 'package:flutter/material.dart';

import '../../widgets/custom_snackbar.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    if (emailController.text.trim() != "" &&
        passwordController.text.trim() != "") {
      String email = emailController.text;

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
