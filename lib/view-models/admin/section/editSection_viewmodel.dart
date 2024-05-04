import 'package:flutter/material.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class EditSectionViewModel extends ChangeNotifier {
  TextEditingController sectionController = TextEditingController();
  List<TextEditingController> fineController = [];

  List<dynamic> rules = [];
  List<dynamic> sectionRules = [];
  List<Map<String, dynamic>> selectedRules = [];
  List<TextEditingController> selectedTime = [];

  bool loading = true;

  Map<String, bool> checkboxValues = {};

  Future<void> getRules(BuildContext context) async {
    selectedRules.clear();
    selectedTime.clear();
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetAllRule',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) async {
        print('Data Processed');
        // sections.add(data);
        // sections = sections.toSet().toList();
        // print(sections);
        rules = await data;
        rules = rules.toSet().toList();
        print(rules);
        for (int i = 0; i < rules.length; i++) {
          fineController.add(TextEditingController());
        }

        for (var rule in rules.map((e) => e['name']).toList()) {
          checkboxValues[rule] = false;
          selectedTime.add(TextEditingController());
        }

        print(selectedTime);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }

  Future<void> getSectionRules(BuildContext context, int id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetSectionDetail?section_id=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) async {
        print('Data Processed');
        sectionRules = await data['rules'];
        sectionRules = sectionRules.toSet().toList();
        print(sectionRules);
        for (var sectionRule in sectionRules) {
          var existingRule = rules.firstWhere(
            (rule) => rule['name'] == sectionRule['rule_name'],
            orElse: () => null,
          );

          if (existingRule != null) {
            int index = rules.indexOf(existingRule);
            fineController[index].text =
                sectionRule['fine'].toString().split('.')[0];
            checkboxValues[sectionRule['rule_name']] = true;
            selectedTime[index].text =
                '${sectionRule['allowed_time'].toString().split(":")[0]}:${sectionRule['allowed_time'].toString().split(":")[1]}';
          }
        }

        print(selectedTime);
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

  Future<void> addSection(context, dynamic section) async {
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
          'name': sectionController.text.trim(),
          "id": section['id'],
          'rules': selectedRules,
        };

        print(newSection);

        await ApiRepo().apiFetch(
          context: context,
          path: 'Section/UpdateSection',
          body: newSection,
          requestMethod: RequestMethod.PUT,
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
}
