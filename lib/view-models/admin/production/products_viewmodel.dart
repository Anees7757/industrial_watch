import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';

class ProductViewModel extends ChangeNotifier {
  List<dynamic> linkedProducts = [];

  bool loading = true;

  Future<void> getProducts(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetLinkedProducts',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
        linkedProducts.clear();
      },
      onSuccess: (data) {
        print('Data Processed');
        linkedProducts = data;
        linkedProducts = linkedProducts.toSet().toList();
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
