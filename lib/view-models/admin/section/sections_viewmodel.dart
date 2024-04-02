import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/screens/admin/section/editSection_screen.dart';
import '../../../views/widgets/custom_snackbar.dart';

class SectionsViewModel extends ChangeNotifier {
  List<dynamic> sections = [];
  bool loading = true;

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
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        customSnackBar(context, error.toString());
        loading = false;
      },
    );
    // notifyListeners();
  }

  void edit(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditSectionScreen(section: sections[index]),
      ),
    );
    notifyListeners();
  }

  void delete(BuildContext context, int index) {
    // if (index >= 0 && index < sections.length) {
    //   sections.removeAt(index);
    //   notifyListeners();
    // }
  }
}
