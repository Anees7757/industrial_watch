import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_dialogbox.dart';
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
    print(productNumber);
    rawMaterials.clear();
    setLoading(true);
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Production/GetFormulaOfProduct?product_number=${Uri.encodeComponent(productNumber)}',
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

  void createBatch(BuildContext context, String product_number) async {
    customDialogBox(
        context,
        Container(
          margin: EdgeInsets.only(left: 18),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              const Text('Please wait...'),
            ],
          ),
        ),
        () {},
        () {},
        "");
    ChooseStockViewmodel chooseStockViewmodel =
        Provider.of<ChooseStockViewmodel>(context, listen: false);

    Map<String, dynamic> batchData = {};
    List<Map<String, dynamic>> stockList = [];

    if (chooseStockViewmodel.selectedStocks.isNotEmpty &&
        batchPerDayController.text.isNotEmpty) {
      Map<int, List<Map<String, dynamic>>> stocksByMaterialId = {};
      for (var stock in chooseStockViewmodel.selectedStocks) {
        int rawMaterialId = stock['raw_material_id'];

        if (stocksByMaterialId.containsKey(rawMaterialId)) {
          stocksByMaterialId[rawMaterialId]!.add(stock);
        } else {
          stocksByMaterialId[rawMaterialId] = [stock];
        }
      }
      stocksByMaterialId.forEach((rawMaterialId, stocks) {
        List<String> stockNumbers =
            stocks.map((stock) => stock['stock_number'] as String).toList();
        stockList.add({
          "raw_material_id": rawMaterialId,
          "stocks": stockNumbers,
        });
      });
      batchData = {
        "batch_per_day": int.parse(batchPerDayController.text),
        "product_number": product_number,
        "stock_list": stockList,
      };
      print(batchData);
      if (stockList.length == rawMaterials.length) {
        await ApiRepo().apiFetch(
          context: context,
          path: 'Production/AddBatch',
          requestMethod: RequestMethod.POST,
          body: batchData,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) {
            print('Data Processed');
            customSnackBar(context, data['message']);
            Navigator.pop(context);
            if (data['message'] == 'Batches Created Successfully') {
              batchPerDayController.clear();
              chooseStockViewmodel.selectedStocks.clear();
              Navigator.pop(context);
            }
            notifyListeners();
          },
          onError: (error) {
            print(error.toString());
            customSnackBar(context, error.toString());
            Navigator.pop(context);
            notifyListeners();
          },
        );
      } else {
        if (stockList.length != rawMaterials.length) {
          List<String> missingMaterials = [];
          for (var material in rawMaterials) {
            int materialId = material['raw_material_id'];

            bool found = stockList
                .any((stock) => stock['raw_material_id'] == materialId);

            if (!found) {
              missingMaterials.add(material['name']);
            }
          }

          String missingMaterialsString = missingMaterials.join(', ');
          customSnackBar(context, 'Missing stock for: $missingMaterialsString');
          Navigator.pop(context);
        }
      }
    } else {
      Navigator.pop(context);
      customSnackBar(context, 'Please fill all fields');
    }
    notifyListeners();
  }
}
