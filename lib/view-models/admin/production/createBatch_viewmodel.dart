import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';
import 'chooseStock_viewmodel.dart';

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
        //customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }

  void getQuantity(BuildContext context) {
    ChooseStockViewmodel chooseStockViewmodel =
        Provider.of<ChooseStockViewmodel>(context, listen: false);

    if (chooseStockViewmodel.selectedStocks.isNotEmpty) {
      for (int i = 0; i < chooseStockViewmodel.selectedStocks.length; i++) {
        var selectedStock = chooseStockViewmodel.selectedStocks[i];
        int totalQuantity = 0;
        totalQuantity += selectedStock['quantity'] as int;
        rawMaterials
            .where((element) =>
                element['raw_material_id'] == selectedStock['raw_material_id'])
            .first['quantity'] = '$totalQuantity KG';
      }
    }
    notifyListeners();
  }
}
