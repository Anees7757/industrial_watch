import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../../../../../view-models/admin/production/addProduct_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    Provider.of<AddProductViewModel>(context, listen: false)
        .getMaterials(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductViewModel>(
        builder: (context, dataProvider, child) {
      return PopScope(
        onPopInvoked: (pop) async {
          dataProvider.nameController.clear();
          dataProvider.toleranceController.clear();
          dataProvider.rawMaterials.clear();
          dataProvider.selectedMaterials.clear();
          dataProvider.selectedAngles.clear();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customAppBar(context, ''),
          body: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _showLabel('Product Name:'),
                CustomTextField(
                  controller: dataProvider.nameController,
                  hintText: 'Screw 1-12',
                  action: TextInputAction.next,
                  textInputType: TextInputType.text,
                  isFocus: false,
                ),
                const SizedBox(height: 8),
                _showLabel('Inspection Angles:'),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 5),
                    width: double.infinity,
                    // height: 56.79,
                    color: const Color(0xFFDDDDDD).withOpacity(0.5),
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) =>
                          dataProvider.dropDownOnChanged(x),
                      options: Provider.of<AddProductViewModel>(context).angles,
                      selectedValues: dataProvider.selectedAngles,
                      whenEmpty: '--- Select ---',
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 0),
                      ),
                      selected_values_style: const TextStyle(
                          fontSize: 16, color: Color(0xFF616161)),
                      hintStyle: const TextStyle(
                          fontSize: 14, color: Color(0xFF616161)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _showLabel('Rejection Tolerance:'),
                CustomTextField(
                  controller: dataProvider.toleranceController,
                  hintText: '0.9',
                  action: TextInputAction.done,
                  textInputType: TextInputType.number,
                  isFocus: false,
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Formula',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(width: 5),
                    Text('per item',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: DataTable(
                    columnSpacing: 30,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.yellow.withOpacity(0.2)),
                    columns: const [
                      DataColumn(
                        numeric: true,
                        label: Text('#'),
                      ),
                      DataColumn(
                        label: Text('Material'),
                      ),
                      DataColumn(
                        label: Text('Quantity'),
                      ),
                    ],
                    rows: dataProvider.selectedMaterials
                        .map(
                          (item) => DataRow(
                            cells: [
                              DataCell(
                                  Text(item['raw_material_id'].toString())),
                              DataCell(
                                Text(dataProvider.rawMaterials
                                    .where((element) =>
                                        element['id'] ==
                                        item['raw_material_id'])
                                    .first['name']),
                              ),
                              DataCell(
                                  Text('${item['quantity']}  ${item['unit']}')),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  dataProvider.addProduct(context);
                },
                child: customButton(
                    context, 'Add Product', 56.79, double.infinity),
              ),
            ),
          ),
        ),
      );
    });
  }
}

_showLabel(txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      txt,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
