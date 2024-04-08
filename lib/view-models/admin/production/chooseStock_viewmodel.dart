import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class ChooseStockViewmodel extends ChangeNotifier {
  List<bool> stockSelections = [];
  bool _loading = true;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
  }

  List<dynamic> stock = [];

  Future<void> getStock(BuildContext context, int rawMaterialId) async {
    stock.clear();
    setLoading(true);
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetStockDetailOfRawMaterial?id=$rawMaterialId',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        stock.addAll(data);
        stock = stock.toSet().toList();
        for (int i = 0; i < stock.length; i++) {
          stockSelections.add(false);
        }
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

  checkBoxOnChanged(bool value, int index) {
    stockSelections[index] = value;
    notifyListeners();
  }

  addBatch(context, int rawMaterialId) {
    List<Map<String, dynamic>> selectedStocks = [];
    for (int i = 0; i < stock.length; i++) {
      if (stockSelections[i]) {
        selectedStocks.add({
          'stock_number': stock[i]['stock_number'],
        });
      }
    }
    if (selectedStocks.isNotEmpty) {
      print({
        rawMaterialId: selectedStocks,
      });
      //apicall
      Navigator.pop(context);
    } else {
      customSnackBar(context, 'Choose Stock');
    }
    notifyListeners();
  }
}
