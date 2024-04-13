import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class ChooseStockViewmodel extends ChangeNotifier {
  List<Map<String, dynamic>> stockSelections = [];
  List<Map<String, dynamic>> selectedStocks = [];
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
        List<bool> checks = [];
        for (int i = 0; i < stock.length; i++) {
          checks.add(false);
        }
        if (!stockSelections
            .any((element) => element['raw_material_id'] == rawMaterialId)) {
          stockSelections.add({
            'raw_material_id': rawMaterialId,
            'stock_checks': checks,
          });
        }
        print(stockSelections);
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

  checkBoxOnChanged(bool value, int index, int rawMaterialId) {
    stockSelections
        .where((element) => element['raw_material_id'] == rawMaterialId)
        .first['stock_checks'][index] = value;
    if (value == false) {
      selectedStocks.removeWhere(
          (element) => element['stock_number'] == stock[index]['stock_number']);
    } else {
      Map<String, dynamic> newStock = {
        'raw_material_id': rawMaterialId,
        'stock_number': stock[index]['stock_number'],
        'quantity': stock[index]['quantity'],
      };
      selectedStocks.add(newStock);
    }
    print(selectedStocks);
    notifyListeners();
  }

  addStock(context, int rawMaterialId) {
    print(rawMaterialId);
    // for (int i = 0; i < stock.length; i++) {
    //   if (stockSelections[i]) {
    //     Map<String, dynamic> newStock = {
    //       'raw_material_id': rawMaterialId,
    //       'stock_number': stock[i]['stock_number'],
    //       'quantity': stock[i]['quantity'],
    //     };
    //     if (!selectedStocks.any(
    //         (element) => element['stock_number'] == newStock['stock_number'])) {
    //       selectedStocks.add(newStock);
    //     }
    //   }
    // }
    if (selectedStocks.isNotEmpty) {
      print(selectedStocks);
      Navigator.pop(context);
    } else {
      customSnackBar(context, 'Choose at least one Stock');
    }
    notifyListeners();
  }
}
