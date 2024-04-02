import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class RulesViewModel extends ChangeNotifier {
  List<dynamic> rules = [];
  TextEditingController ruleController = TextEditingController();
  bool loading = true;

  Future<void> getRules(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Rule/get_all_rules',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        rules = data;
        rules = rules.toSet().toList();
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        customSnackBar(context, error.toString());
      },
    );
  }

  addRule(BuildContext context) async {
    if (ruleController.text.isNotEmpty) {
      if (!rules.contains(ruleController.text)) {
        await ApiRepo().apiFetch(
          context: context,
          path: 'Rule/add_rule?name=${ruleController.text}',
          requestMethod: RequestMethod.POST,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) {
            print(data['message']);
            customSnackBar(context, data['message']);
            // rules.add(
            //     {'id': '${rules.last['id'] + 1}', 'name': ruleController.text});
            getRules(context);
            notifyListeners();
          },
          onError: (error) {
            print(error.toString());
            customSnackBar(context, error.toString());
          },
        );
        if (!context.mounted) return;
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

  Future<void> delete(BuildContext context, int index) async {
    await ApiRepo().apiFetch(
      context: context,
      path: 'Rule/delete_rule?id=${rules[index]['id']}',
      requestMethod: RequestMethod.DELETE,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print(data['message']);
        rules.removeAt(index);
        customSnackBar(context, data['message']);
      },
      onError: (error) {
        print(error.toString());
        customSnackBar(context, error.toString());
      },
    );
    notifyListeners();
  }
}
