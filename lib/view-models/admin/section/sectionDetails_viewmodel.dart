import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class SectionDetailViewModel extends ChangeNotifier {
  Map<String, dynamic> rules = {};
  bool loading = true;

  Future<void> fetchData(BuildContext context, int id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetSectionRules?id=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        loading = true;
        print('Processing Data');
      },
      onSuccess: (data) async {
        try {
          print('Data Processed');
          print(data);
          rules = data;
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
