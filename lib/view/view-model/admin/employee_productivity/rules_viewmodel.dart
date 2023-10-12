import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_snackbar.dart';
import '../section/addSection_viewmodel.dart';

class RulesViewModel extends ChangeNotifier {
  TextEditingController ruleController = TextEditingController();

  AddSectionViewModel? _addSectionViewModel;

  addRule(BuildContext context) {
    _addSectionViewModel =
        Provider.of<AddSectionViewModel>(context, listen: false);
    if(ruleController.text.isNotEmpty) {
      if (!_addSectionViewModel!.rules.keys.contains(ruleController.text)) {
        _addSectionViewModel!.rules.addAll({
          ruleController.text: 0,
        });
        Navigator.of(context).pop();
        ruleController.clear();
      } else {
        customSnackBar(context, 'Rule Already exists');
      }
    }
    notifyListeners();
  }

  navigate(BuildContext context) {
    Navigator.pop(context);
    ruleController.clear();
    notifyListeners();
  }

  void delete(BuildContext context, int index) {
    _addSectionViewModel =
        Provider.of<AddSectionViewModel>(context, listen: false);
    if (index >= 0 && index < _addSectionViewModel!.rules.length) {
      _addSectionViewModel!.rules
          .remove(_addSectionViewModel!.rules.keys.elementAt(index));
      notifyListeners();
    }
  }
}
