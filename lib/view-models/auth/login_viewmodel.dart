import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:industrial_watch/repositories/api_repo.dart';
import 'package:industrial_watch/utils/shared_prefs/shared_prefs.dart';

import '../../global/global.dart';
import '../../utils/request_methods.dart';
import '../../views/widgets/custom_dialogbox.dart';
import '../../views/widgets/custom_snackbar.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(BuildContext context) async {
    if (usernameController.text.trim() != "" &&
        passwordController.text.trim() != "") {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      await ApiRepo().apiFetch(
        context: context,
        path: 'User/Login?username=$username&password=$password',
        requestMethod: RequestMethod.GET,
        beforeSend: () {
          customDialogBox(
              context,
              Container(
                margin: EdgeInsets.only(left: 18),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    SizedBox(
                      width: 20,
                    ),
                    const Text('Please wait...'),
                  ],
                ),
              ),
              () {},
              () {},
              "");
          print('Processing Data');
        },
        onSuccess: (data) async {
          print('Data Processed');
          Navigator.pop(context);
          if (data['role'] == null) {
            customSnackBar(context, data['message']);
            throw ();
          }
          userData = data;
          debugPrint("role: ${data['role'].toString().toLowerCase()}");
          await DataSharedPrefrences.setUser(jsonEncode(userData));
          if (!context.mounted) return;
          Navigator.of(context).pushReplacementNamed(
              '/${userData['role'].toString().toLowerCase()}');
          customSnackBar(context, 'Login Successful');

          usernameController.clear();
          passwordController.clear();
          // switch (userData['role'].toString().toLowerCase()) {
          //   case 'admin':
          //     if (!context.mounted) return;
          //     Navigator.of(context).pushReplacementNamed('/admin');
          //     customSnackBar(context, 'Login Successful');
          //
          //     usernameController.clear();
          //     passwordController.clear();
          //     break;
          //   case 'supervisor':
          //     if (!context.mounted) return;
          //     Navigator.of(context).pushReplacementNamed('/supervisor');
          //     customSnackBar(context, 'Login Successful');
          //
          //     usernameController.clear();
          //     passwordController.clear();
          //     break;
          //   case 'employee':
          //     if (!context.mounted) return;
          //     customSnackBar(context, 'Login Successful');
          //     Navigator.of(context).pushReplacementNamed('/employee');
          //
          //     usernameController.clear();
          //     passwordController.clear();
          //     break;
          //   default:
          //     customSnackBar(context, 'Wrong Credentials');
          //}
        },
        onError: (error) {
          Navigator.pop(context);
          print(error.toString());
        },
      );
    } else {
      customSnackBar(context, 'All field must be filled');
    }
    notifyListeners();
  }
}
