import 'package:flutter/cupertino.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class BatchDetailsViewModel extends ChangeNotifier {
  Map<String, dynamic> batchDetails = {};

  bool loading = true;

  Future<void> getBatchDetails(BuildContext context, String id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetBatch?batch_number=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        batchDetails = data;
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        //customSnackBar(context, error.toString());
      },
    );
  }
}
