import 'package:flutter/material.dart';

import '../../../views/screens/admin/section/editSection_screen.dart';

class SectionsViewModel extends ChangeNotifier {
 List<String> sections = ['Packing', 'Management', 'Manufacturing'];

  // Map<String, dynamic> sections = {
  //   'Manufacturing': {
  //     'Mobile Usage': 500,
  //     'Smoking': 300,
  //     'Gossiping': 500,
  //   },
  //   'Packing': {
  //     'Mobile Usage': 500,
  //     'Smoking': 1000,
  //     'Gossiping': 200,
  //   },
  //   'Management': {
  //     'Smoking': 200,
  //   }
  // };


  void edit(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditSectionScreen(section: sections[index]),
      ),
    );
    notifyListeners();
  }

  void delete(BuildContext context, int index) {
    if (index >= 0 && index < sections.length) {
      sections.removeAt(index);
      notifyListeners();
    }
  }
}
