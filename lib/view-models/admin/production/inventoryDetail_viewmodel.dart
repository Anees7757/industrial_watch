import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class InventoryDetailViewModel extends ChangeNotifier {
  List<dynamic> inventoryDetailsList = [];

  bool loading = true;

  Future<void> getInventoryDetails(BuildContext context, int id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetStockDetailOfRawMaterial?id=$id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        inventoryDetailsList = data;
        inventoryDetailsList = inventoryDetailsList.toSet().toList();
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
