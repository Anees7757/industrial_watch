import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/section/sections_viewmodel.dart';
import 'package:provider/provider.dart';

class AddSectionViewModel extends ChangeNotifier {
  TextEditingController sectionController = TextEditingController();

  Map<String, int> rules = {
    'Mobile Usage': 500,
    'Smoking': 300,
    'Gossiping': 200,
  };

  Map<String, bool> checkboxValues = {};

  void addSection(context) {
    SectionsViewModel sectionsViewModel =
        Provider.of<SectionsViewModel>(context, listen: false);
    sectionsViewModel.sections.add(sectionController.text);

    sectionController.clear();
    Navigator.pop(context);

    notifyListeners();
  }

  checkboxHandle(bool value, int index) {
    checkboxValues[rules.keys.elementAt(index)] = value;
    notifyListeners();
  }
}