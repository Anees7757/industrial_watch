import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/production/production_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../views/widgets/custom_dialogbox.dart';
import '../../../views/widgets/custom_textfield.dart';

class CreateBatchViewModel extends ChangeNotifier {
  TextEditingController batchController = TextEditingController();
  TextEditingController toleranceController = TextEditingController();
  TextEditingController anglesController = TextEditingController();

  //dialog Controllers
  TextEditingController materialNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController quantityPerItemController = TextEditingController();

  //TextEditingController priceController = TextEditingController();

  List<Map<String, String>> rawMaterials = [
    // {
    //   'number': '1',
    //   'name': 'Iron',
    //   'quantity': '160 KG',
    //   'quantityPerItem': '500 G',
    // },
    // {
    //   'number': '2',
    //   'name': 'Steel',
    //   'quantity': '120 KG',
    //   'quantityPerItem': '400 G',
    // },
  ];

  void addSection(context) {
    ProductionViewModel productionViewModel =
        Provider.of<ProductionViewModel>(context, listen: false);

    Map<String, dynamic> batch = {
      'Batch#${batchController.text}': [
        'P#110212323',
        'P#110111523',
      ],
    };

    productionViewModel.batches.addAll(batch);

    batchController.clear();
    toleranceController.clear();
    rawMaterials.clear();

    Navigator.pop(context);
    notifyListeners();
  }

  void showDialog(context) {
    customDialogBox(context, dialogData(context), () {
      Navigator.pop(context);
    }, () {
      rawMaterials.add({
        'number': (rawMaterials.length + 1).toString(),
        'name': materialNameController.text,
        'quantity': quantityController.text,
        'quantityPerItem': quantityPerItemController.text,
      });
      Navigator.pop(context);
    }, 'Add');

    materialNameController.clear();
    quantityController.clear();
    quantityPerItemController.clear();
    notifyListeners();
  }

  List<String> units = [
    'G',
    'KG',
  ];

  String selectedQuantityUnit = '';
  String selectedQuantityPerItemUnit = '';

  Widget dialogData(context) {
    selectedQuantityUnit = units.first;
    selectedQuantityPerItemUnit = units.first;

    return Column(
      children: [
        const Text('Add Material',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 25),
        CustomTextField(
          controller: materialNameController,
          hintText: 'Name',
          action: TextInputAction.next,
          textInputType: TextInputType.text,
          isFocus: false,
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            CustomTextField(
              controller: quantityController,
              hintText: 'Quantity',
              action: TextInputAction.next,
              textInputType: TextInputType.number,
              isFocus: false,
            ),
            DropdownButton(
              value: selectedQuantityUnit,
              items: units
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                selectedQuantityUnit = v!;
                notifyListeners();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            CustomTextField(
              controller: quantityPerItemController,
              hintText: 'Quantity per item',
              action: TextInputAction.done,
              textInputType: TextInputType.number,
              isFocus: false,
            ),
            DropdownButton(
              value: selectedQuantityPerItemUnit,
              items: units
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                selectedQuantityPerItemUnit = v!;
                notifyListeners();
              },
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
