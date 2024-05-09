import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:industrial_watch/models/employee_model.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class EmployeeRecordViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<dynamic> sections = [];
  List<dynamic> employees = [];
  List<dynamic> filteredEmployees = [];
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

  dropDownOnChanged(Map<String, dynamic> item) {
    selectedSection = item;
    print(selectedSection);
    notifyListeners();
  }

  Future<void> getEmployees(BuildContext context, int section_id) async {
    loadingEmployees = true;
    employees.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetAllEmployees?section_id=$section_id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        employees = data;
        employees = employees.toSet().toList();
        filteredEmployees = employees;
        print("Employees >>>>> " + employees.toString());
        loadingEmployees = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loadingEmployees = false;
        notifyListeners();
      },
    );
  }

  search(context, query) {
    if (query != "") {
      filteredEmployees.clear();
      filteredEmployees
          .addAll(employees.where((element) => element['name'] == query));
    }
  }
}
