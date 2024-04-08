import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class CreateBatchViewmodel extends ChangeNotifier {
  TextEditingController batchPerDayController = TextEditingController();

  bool _loading = true;
  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
  }

  List<dynamic> rawMaterials = [];
  Map<String, dynamic> selectedProduct = {};

  Future<void> getRawMaterials(
      BuildContext context, String productNumber) async {
    rawMaterials.clear();
    setLoading(true);
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetFormulaOfProduct?product_number=$productNumber',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        rawMaterials.addAll(data);
        rawMaterials = rawMaterials.toSet().toList();
        setLoading(false);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }
}
