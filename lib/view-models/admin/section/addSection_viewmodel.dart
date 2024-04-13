import 'package:flutter/material.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class AddSectionViewModel extends ChangeNotifier {
  TextEditingController sectionController = TextEditingController();
  List<TextEditingController> fineController = [];

  List<dynamic> rules = [];
  List<Map<String, dynamic>> selectedRules = [];
  List<TextEditingController> selectedTime = [];

  bool loading = true;

  Map<String, bool> checkboxValues = {};

  Future<void> addSection(context) async {
    if (sectionController.text.isNotEmpty) {
      if (checkboxValues.containsValue(true)) {
        int index = 0;
        for (var i in checkboxValues.entries) {
          if (i.value == true) {
            selectedRules.add({
              'rule_id': rules
                  .where((element) => element['name'] == i.key)
                  .first['id'],
              'fine': fineController[index].text,
              'allowed_time': selectedTime[index].text
            });
          }
          index++;
        }

        Map<String, dynamic> newSection = {
          'name': sectionController.text,
          'rules': selectedRules,
        };

        print(newSection);

        await ApiRepo().apiFetch(
          context: context,
          path: 'Section/InsertSection',
          body: newSection,
          requestMethod: RequestMethod.POST,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) {
            print('Data Processed');
            print(data);
            customSnackBar(context, data['message']);
            sectionController.clear();
            selectedRules.clear();
            fineController.clear();
            Navigator.pop(context);
          },
          onError: (error) {
            print(error.toString());
            //customSnackBar(context, error.toString());
            notifyListeners();
          },
        );
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

  Future<void> getRules(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Rule/get_all_rules',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        loading = true;
        print('Processing Data');
      },
      onSuccess: (data) async {
        try {
          print('Data Processed');
          print(data);
          rules = await data;
          rules = rules.toSet().toList();
          for (int i = 0; i < rules.length; i++) {
            fineController.add(TextEditingController());
          }

          for (var rule in rules.map((e) => e['name']).toList()) {
            checkboxValues[rule] = false;
            selectedTime.add(TextEditingController());
          }

          print(selectedTime);

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
        //customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }
}
