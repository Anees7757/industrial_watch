import 'package:flutter/cupertino.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class InventoryViewModel extends ChangeNotifier {
  List<dynamic> inventoryList = [];

  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String selectedMaterial = 'Choose Material';

  String selectedUnit = 'G';

  bool loading = true;

  Future<void> getInventory(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetAllInventory',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        inventoryList = data;
        inventoryList = inventoryList.toSet().toList();
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

  addStock(BuildContext context) async {
    if (priceController.text.isNotEmpty && quantityController.text.isNotEmpty) {
      await ApiRepo().apiFetch(
        context: context,
        path: 'Production/AddStock',
        requestMethod: RequestMethod.POST,
        body: {
          'raw_material_id': inventoryList
              .where(
                  (element) => element['raw_material_name'] == selectedMaterial)
              .first['raw_material_id'],
          'unit': selectedUnit,
          'price_per_unit': double.parse(priceController.text),
          'quantity': int.parse(quantityController.text)
        },
        beforeSend: () {
          print('Processing Data');
        },
        onSuccess: (data) async {
          print(data['message']);
          customSnackBar(context, data['message']);
          await getInventory(context);
          priceController.clear();
          quantityController.clear();
        },
        onError: (error) {
          print(error.toString());
          customSnackBar(context, error.toString());
        },
      );
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } else {
      customSnackBar(context, 'Please fill in all fields');
    }
  }

  navigate(BuildContext context) {
    Navigator.pop(context);
    quantityController.clear();
    priceController.clear();
    notifyListeners();
  }
}
