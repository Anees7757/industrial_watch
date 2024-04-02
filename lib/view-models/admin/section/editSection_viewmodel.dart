import 'package:flutter/material.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class EditSectionViewModel extends ChangeNotifier {
  TextEditingController sectionController = TextEditingController();
  List<TextEditingController> fineController = [];

  List<dynamic> rules = [];
  List<Map<String, dynamic>> selectedRules = [];
  List<TextEditingController> selectedTime = [];

  bool loading = true;

  Map<String, bool> checkboxValues = {};

  Future<void> addSection(context, Map<String, dynamic> section) async {
    if (sectionController.text.isNotEmpty) {
      if (checkboxValues.containsValue(true)) {
        int index = 0;
        for (var i in checkboxValues.entries) {
          if (i.value == true) {
            selectedRules.add({
              'rule_id': rules
                  .where((element) => element['rule_name'] == i.key)
                  .first['id'],
              'fine': fineController[index].text,
              'allowed_time': selectedTime[index].text
            });
          }
          index++;
        }

        Map<String, dynamic> newSection = {
          'id': section['id'],
          'name': sectionController.text,
          'rules': selectedRules,
        };

        print(newSection);
        //
        // await ApiRepo().apiFetch(
        //   context: context,
        //   path: 'Section/insert_section',
        //   body: newSection,
        //   requestMethod: RequestMethod.POST,
        //   beforeSend: () {
        //     print('Processing Data');
        //   },
        //   onSuccess: (data) {
        //     print('Data Processed');
        //     print(data);
        //     customSnackBar(context, data['message']);
        //     sectionController.clear();
        //     selectedRules.clear();
        //     fineController.clear();
        //     Navigator.pop(context);
        //   },
        //   onError: (error) {
        //     print(error.toString());
        //     customSnackBar(context, error.toString());
        //   },
        // );
      } else {
        customSnackBar(context, "Choose at least one rule");
      }
    } else {
      customSnackBar(context, "Please Enter Section Name");
    }
    notifyListeners();
  }

  checkboxHandle(bool value, int index) {
    checkboxValues[rules.elementAt(index)['name']] = value;
    if (value == false) {
      fineController[index].clear();
      selectedTime[index].clear();
    }
    notifyListeners();
  }

  Future<void> getRules(BuildContext context, int id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/get_section_rules?id=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        loading = true;
        print('Processing Data');
      },
      onSuccess: (data) async {
        try {
          print('Data Processed');
          print(data);
          rules = await data['rules'];
          rules = rules.toSet().toList();
          for (var i in rules) {
            fineController.add(TextEditingController());
            checkboxValues[i['rule_name']] = true;
            selectedTime.add(TextEditingController());
          }
          for (var i = 0; i < rules.length; i++) {
            fineController[i].text = rules[i]['fine'].toStringAsFixed(2);
            selectedTime[i].text = rules[i]['allowed_time'].toString();
          }

          print(checkboxValues);

          loading = false;
          notifyListeners();
        } catch (e) {
          // if (!context.mounted) return;
          print(e);
          // customSnackBar(context, e.toString());
        }
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }
}
