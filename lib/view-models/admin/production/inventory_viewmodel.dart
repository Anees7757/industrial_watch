import 'package:flutter/material.dart';

import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';
import '../../../views/widgets/custom_textfield.dart';

class InventoryViewModel extends ChangeNotifier {
  List<dynamic> inventoryList = [];

  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  List<dynamic> rawMaterials = [];
  int rawMaterialId = -1;

  String selectedUnit = 'G';

  bool _loading = true;

  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
  }

  Future<void> getInventory(BuildContext context) async {
    setLoading(true);
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
        setLoading(false);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        setLoading(false);
        //customSnackBar(context, error.toString());
      },
    );
  }

  Future<void> getMaterials(BuildContext context) async {
    rawMaterials.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetAllRawMaterials',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        rawMaterials.add(
          {"id": -1, "name": "-- Choose --"},
        );
        rawMaterials.addAll(data);
        rawMaterials = rawMaterials.toSet().toList();
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
      },
    );
  }

  addStock(BuildContext context) async {
    if (priceController.text.isNotEmpty && quantityController.text.isNotEmpty) {
      if (rawMaterialId != -1) {
        // inventoryList
        //     .where(
        //         (element) => element['raw_material_name'] == selectedMaterial)
        //     .first['raw_material_id']

        dynamic data = {
          'raw_material_id': rawMaterialId,
          // 'unit': selectedUnit,
          'price_per_kg': double.parse(priceController.text),
          'quantity': int.parse(quantityController.text)
        };
        print(data);
        await ApiRepo().apiFetch(
          context: context,
          path: 'Production/AddStock',
          requestMethod: RequestMethod.POST,
          body: data,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) async {
            print(data['message']);
            customSnackBar(context, data['message']);
            priceController.clear();
            quantityController.clear();
            rawMaterialId = -1;
            await getInventory(context);
          },
          onError: (error) {
            print(error.toString());
            //customSnackBar(context, error.toString());
            notifyListeners();
          },
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
      } else {
        customSnackBar(context, 'Please choose Raw Material');
      }
    } else {
      customSnackBar(context, 'Please fill in all fields');
    }
  }

  navigate(BuildContext context) {
    Navigator.pop(context);
    quantityController.clear();
    priceController.clear();
    rawMaterialId = -1;
    notifyListeners();
  }

  // List<String> units = [
  //   'G',
  //   'KG',
  // ];
  //
  // String selectedQuantityUnit = '';

  Widget dialogData(context) {
    rawMaterials = rawMaterials.toSet().toList();
    print(rawMaterials);
    // selectedQuantityUnit = units.first;

    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          const Text('Add Stock',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 25),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Product Name:'),
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              width: double.infinity,
              // height: 56.79,
              color: const Color(0xFFDDDDDD).withOpacity(0.5),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  icon: Visibility(
                      visible: rawMaterials.isEmpty ? false : true,
                      child: Icon(Icons.arrow_drop_down)),
                  hint: rawMaterials.isEmpty
                      ? const Text('No Raw Material Found')
                      : null,
                  value: rawMaterialId,
                  items: rawMaterials.map<DropdownMenuItem<int>>((map) {
                    return DropdownMenuItem<int>(
                      value: map['id'],
                      child: Text(map['name']),
                    );
                  }).toList(),
                  onChanged: (v) {
                    rawMaterialId = v!;
                    setState(() {});
                    // notifyListeners();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Quantity/KG:'),
          ),
          const SizedBox(height: 5),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextField(
                controller: quantityController,
                hintText: 'e.g 12',
                action: TextInputAction.next,
                textInputType: TextInputType.number,
                isFocus: false,
              ),
              // DropdownButton(
              //   value: selectedQuantityUnit,
              //   items: units
              //       .map(
              //         (e) => DropdownMenuItem(
              //           value: e,
              //           child: Text(e),
              //         ),
              //       )
              //       .toList(),
              //   onChanged: (v) {
              //     selectedQuantityUnit = v!;
              //     setState(() {});
              //   },
              // ),
            ],
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Price/KG:'),
          ),
          const SizedBox(height: 5),
          CustomTextField(
            controller: priceController,
            hintText: 'e.g 200',
            action: TextInputAction.done,
            textInputType: TextInputType.number,
            isFocus: false,
          ),
          const SizedBox(height: 25),
        ],
      );
    });
  }
}
