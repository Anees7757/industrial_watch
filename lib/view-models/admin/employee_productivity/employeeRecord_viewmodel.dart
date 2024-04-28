import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class EmployeeRecordViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<dynamic> sections = [];
  Map<String, dynamic> selectedSection = {};

  bool loadingSections = true;

  Future<void> getSections(BuildContext context) async {
    loadingSections = true;
    sections.clear();
    selectedSection = {};
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetAllSections?status=1',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        sections.add({
          'id': -1,
          'name': "All Sections",
        });
        selectedSection = sections.first;
        for (var i in data) {
          sections.add(i);
        }
        sections = sections.toSet().toList();
        print("Sections >>>>> " + sections.toString());
        loadingSections = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loadingSections = false;
        notifyListeners();
      },
    );
  }

  dropDownOnChanged(Map<String, dynamic> item) {
    selectedSection = item;
    notifyListeners();
  }
}
