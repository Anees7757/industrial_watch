import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/supervisor/supervisorsView_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class AddSupervisorViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = true;

  List<dynamic> sections = [];

  List<String> selectedSections = [];

  void createAccount(BuildContext context) {
    if (nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        selectedSections.isNotEmpty) {
      SupervisorsViewModel supervisorsViewModel =
          Provider.of<SupervisorsViewModel>(context, listen: false);
      // Map<String, dynamic> user = {
      //   nameController.text: {
      //     'username': usernameController.text,
      //     'password': passwordController.text,
      //     'sections': selectedSections
      //   },
      // };
      // supervisorsViewModel.supervisors.addAll(user);

      print(supervisorsViewModel.supervisors);

      nameController.clear();
      usernameController.clear();
      passwordController.clear();
      selectedSections.clear();

      Navigator.of(context).pop();
      notifyListeners();
    } else {
      customSnackBar(
          context, 'Please fill all fields and select at least one section');
    }
  }

  dropDownOnChanged(List<String> x) {
    selectedSections = x;
    notifyListeners();
  }

  Future<void> getSections(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/get_all_sections',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        sections = data;
        sections = sections.toSet().toList();
        print(sections);
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        customSnackBar(context, error.toString());
        loading = false;
      },
    );
  }
}
