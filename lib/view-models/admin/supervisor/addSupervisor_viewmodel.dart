import 'package:flutter/material.dart';

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
      List<Map<String, dynamic>> selectedSectionsList = [];

      for (var element in sections) {
        if (selectedSections.contains(element.key)) {
          selectedSectionsList.add({
            'section_id': element['id'],
            'name': element['name'],
          });
        }
      }

      Map<String, dynamic> supervisor = {
        'name': nameController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'role': 'Supervisor',
        'sections': selectedSectionsList
      };
      print(supervisor);

      // nameController.clear();
      // usernameController.clear();
      // passwordController.clear();
      // selectedSections.clear();
      //
      // Navigator.of(context).pop();
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
        //customSnackBar(context, error.toString());
        loading = false;
      },
    );
  }
}
