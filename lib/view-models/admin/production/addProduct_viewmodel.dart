import 'package:flutter/material.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_dialogbox.dart';
import '../../../views/widgets/custom_snackbar.dart';
import '../../../views/widgets/custom_textfield.dart';

class AddProductViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  int? selectedMaterialId;
  TextEditingController quantityController = TextEditingController();

  List<String> angles = [
    'Left',
    'Right',
    'Top',
    'Bottom',
    'Front Flip',
    'Back Flip',
  ];
  List<String> selectedAngles = [];
  List<dynamic> rawMaterials = [];
  List<Map<String, dynamic>> selectedMaterials = [];

  Future<void> getMaterials(BuildContext context) async {
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
        customSnackBar(context, error.toString());
      },
    );
  }

  addProduct(context) async {
    Map<String, dynamic> newProduct = {};

    if (selectedMaterials.isNotEmpty ||
        nameController.text.isNotEmpty ||
        selectedAngles.isNotEmpty && selectedMaterialId != -1) {
      newProduct = {
        "name": nameController.text,
        "inspection_angles": selectedAngles.join(','),
        "materials": selectedMaterials.map((e) {
          return {
            "raw_material_id": e['raw_material_id'],
            "quantity": int.parse(e['quantity']),
            "unit": e['unit']
          };
        }).toList()
      };

      print(newProduct);

      await ApiRepo().apiFetch(
        context: context,
        path: 'Production/AddProduct',
        body: newProduct,
        requestMethod: RequestMethod.POST,
        beforeSend: () {
          print('Processing Data');
        },
        onSuccess: (data) {
          print('Data Processed');
          print(data);
          customSnackBar(context, data['message']);
          nameController.clear();
          selectedMaterials.clear();
          selectedAngles.clear();
          Navigator.pop(context);
        },
        onError: (error) {
          print(error.toString());
          customSnackBar(context, error.toString());
        },
      );
    } else {
      customSnackBar(context, "Please fill all fields");
    }
  }

  void showDialog(context) {
    customDialogBox(context, dialogData(context), () {
      Navigator.pop(context);
      selectedMaterialId = -1;
      quantityController.clear();
    }, () {
      if (selectedMaterialId != -1) {
        // if (!selectedMaterials.any(
        //     (element) => element['raw_material_id'] == selectedMaterialId)) {
        selectedMaterials.add({
          'raw_material_id': selectedMaterialId,
          'quantity': quantityController.text,
          'unit': selectedQuantityUnit
        });
        selectedMaterialId = -1;
        quantityController.clear();
        print(selectedMaterials);
        Navigator.pop(context);
        notifyListeners();
        // } else {
        //   customSnackBar(context, 'Raw Material already added');
        // }
      } else {
        customSnackBar(context, 'Choose Raw Material');
      }
      notifyListeners();
    }, 'Add');
  }

  dropDownOnChanged(List<String> x) {
    selectedAngles = x;
    notifyListeners();
  }

  List<String> units = [
    'G',
    'KG',
  ];

  String selectedQuantityUnit = '';

  Widget dialogData(context) {
    rawMaterials = rawMaterials.toSet().toList();
    print(rawMaterials);
    selectedQuantityUnit = units.first;

    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          const Text('Add Material',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              width: double.infinity,
              // height: 56.79,
              color: const Color(0xFFDDDDDD).withOpacity(0.5),
              child: DropdownButton(
                hint: const Text('-- Choose --'),
                isExpanded: true,
                underline: const SizedBox(),
                value: selectedMaterialId,
                items: rawMaterials.map<DropdownMenuItem<int>>((map) {
                  return DropdownMenuItem<int>(
                    value: map['id'],
                    child: Text(map['name']),
                  );
                }).toList(),
                onChanged: (v) {
                  selectedMaterialId = v!;
                  setState(() {});
                  // notifyListeners();
                },
              ),
            ),
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
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      );
    });
  }
}
