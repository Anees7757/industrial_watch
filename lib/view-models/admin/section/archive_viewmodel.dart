import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class ArchivesViewModel extends ChangeNotifier {
  List<dynamic> sections = [];
  bool loading = true;

  Future<void> getSections(BuildContext context) async {
    loading = true;
    sections.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetAllSections?status=0',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        sections = data;
        sections = sections.toSet().toList();
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loading = false;
        notifyListeners();
      },
    );
  }

  Future<void> archive(context, int id) async {
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/ChangeSectionAcitivityStatus?section_id=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        print(data);
        customSnackBar(context, data['message']);
        getSections(context);
        // notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }
}
