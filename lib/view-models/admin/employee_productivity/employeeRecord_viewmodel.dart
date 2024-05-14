import 'package:flutter/material.dart';
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

  EmployeeRecordViewModel() {
    searchController.addListener(_filterEmployees);
  }

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
        loadingSections = false;
        notifyListeners();
      },
    );
  }

  void dropDownOnChanged(Map<String, dynamic> item) {
    selectedSection = item;
    print(selectedSection);
    notifyListeners();
  }

  Future<void> getEmployees(BuildContext context, int section_id) async {
    loadingEmployees = true;
    employees.clear();
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Employee/GetAllEmployees?section_id=$section_id&ranking_required=0',
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
        loadingEmployees = false;
        notifyListeners();
      },
    );
  }

  void _filterEmployees() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredEmployees = employees;
    } else {
      filteredEmployees = employees.where((employee) {
        return employee['name'].toLowerCase().contains(query) ||
            employee['section_name'].toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }
}
