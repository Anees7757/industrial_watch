import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class EmployeesRankingViewModel extends ChangeNotifier {
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
}
