import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_dialogbox.dart';
import '../../../views/widgets/custom_snackbar.dart';

class EditSupervisorViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = true;

  List<dynamic> sections = [];

  List<String> selectedSections = [];

  Future<void> updateSupervisor(BuildContext context, int employeeId) async {
    if (nameController.text.isNotEmpty &&
        usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        selectedSections.isNotEmpty) {
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
      List<Map<String, dynamic>> selectedSectionsList = [];

      for (var element in sections) {
        if (selectedSections.contains(element['name'])) {
          selectedSectionsList.add({
            'id': element['id'],
            // 'name': element['name'],
          });
        }
      }

      Map<String, dynamic> supervisor = {
        'employee_id': employeeId,
        'name': nameController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'sections': selectedSectionsList
      };
      print(supervisor);

      await ApiRepo().apiFetch(
        context: context,
        path: 'Employee/UpdateSupervisor',
        body: supervisor,
        requestMethod: RequestMethod.PUT,
        beforeSend: () {
          print('Processing Data');
        },
        onSuccess: (data) {
          print(data);
          customSnackBar(context, data['message']);
          nameController.clear();
          usernameController.clear();
          passwordController.clear();
          selectedSections.clear();

          Navigator.of(context).pop();
          Navigator.of(context).pop();
          notifyListeners();
        },
        onError: (error) {
          print(error.toString());
          customSnackBar(context, error);
          Navigator.of(context).pop();
          loading = false;
        },
      );
    } else {
      customSnackBar(
          context, 'Please fill all fields and select at least one section');
    }
  }

  dropDownOnChanged(List<String> x) {
    selectedSections = x;
    notifyListeners();
  }

  Future<void> getAllSections(BuildContext context) async {
    loading = true;
    sections.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetAllSections?status=1',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        for (var i in data) {
          sections.add(i);
        }
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

  Future<void> getSupervisorSections(BuildContext context, int id) async {
    selectedSections.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetSupervisorDetail?supervisor_id=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        print("Supervisor Sections >>> " + data.toString());
        for (var i in data.first['sections']) {
          selectedSections.add(i['name']);
        }
        selectedSections = selectedSections.toSet().toList();
        usernameController.text = data.first['username'];
        passwordController.text = data.first['password'];
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }
}
