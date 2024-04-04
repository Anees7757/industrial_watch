import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class BatchViewModel extends ChangeNotifier {
  List<dynamic> batches = [];

  bool loading = true;

  Future<void> getBatches(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetAllBatch',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        batches = data;
        batches = batches.toSet().toList();
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
}
