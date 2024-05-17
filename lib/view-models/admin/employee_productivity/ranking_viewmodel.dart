import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class EmployeesRankingViewModel extends ChangeNotifier {
  bool isReversed = false;
  List<dynamic> sections = [];
  List<dynamic> employees = [];
  Map<String, dynamic> selectedSection = {};

  bool loadingSections = true;
  bool loadingEmployees = true;

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

  sectionDropDownOnChanged(Map<String, dynamic> item) {
    selectedSection = item;
    notifyListeners();
  }

  Future<void> getEmployees(BuildContext context, int section_id) async {
    loadingEmployees = true;
    employees.clear();
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Employee/GetAllEmployees?section_id=$section_id&ranking_required=1',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        employees = data;
        employees = employees.toSet().toList();
        print("Employees >>>>> " + employees.toString());
        loadingEmployees = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loadingEmployees = false;
        notifyListeners();
      },
    );
  }

  changeOrder(val) {
    if (val == 0) {
      if (isReversed == true) {
        employees = employees.reversed.toList();
        isReversed = false;
        notifyListeners();
      }
    } else {
      if (isReversed == false) {
        employees = employees.reversed.toList();
        isReversed = true;
        notifyListeners();
      }
    }
  }
}
