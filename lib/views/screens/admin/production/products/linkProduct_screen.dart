import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';
import '../../../../../view-models/admin/production/linkProduct_viewmodel.dart';
import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_textfield.dart';

class LinkProductScreen extends StatefulWidget {
  const LinkProductScreen({super.key});

  @override
  State<LinkProductScreen> createState() => _LinkProductScreenState();
}

class _LinkProductScreenState extends State<LinkProductScreen> {
  @override
  void initState() {
    Provider.of<LinkProductViewModel>(context, listen: false)
        .getProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LinkProductViewModel>(
        builder: (context, dataProvider, child) {
      return PopScope(
        onPopInvoked: (pop) async {
          dataProvider.toleranceController.clear();
          dataProvider.pieceController.clear();
          dataProvider.packsController.clear();
          dataProvider.selectedProduct.clear();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: const Text('Link Product'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _showLabel('Product Name'),
                Provider.of<LinkProductViewModel>(context, listen: true).loading
                    ? CustomTextField(
                        controller: TextEditingController(text: 'Loading...'),
                        hintText: '',
                        action: TextInputAction.next,
                        textInputType: TextInputType.number,
                        isFocus: false,
                        readOnly: true,
                      )
                    : dataProvider.products.isEmpty
                        ? CustomTextField(
                            controller:
                                TextEditingController(text: 'No Product Found'),
                            hintText: '',
                            action: TextInputAction.next,
                            textInputType: TextInputType.number,
                            isFocus: false,
                            readOnly: true,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 5, bottom: 5),
                              width: double.infinity,
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                              child: DropdownButton<Map<String, dynamic>>(
                                isExpanded: true,
                                underline: const SizedBox(),
                                hint: const Text('-- Select Product --'),
                                value: dataProvider.selectedProduct.isNotEmpty
                                    ? dataProvider.selectedProduct
                                    : null,
                                items: dataProvider.products.map<
                                        DropdownMenuItem<Map<String, dynamic>>>(
                                    (map) {
                                  return DropdownMenuItem<Map<String, dynamic>>(
                                    value: map,
                                    child: Text(map['name']),
                                  );
                                }).toList(),
                                onChanged: (Map<String, dynamic>? selectedMap) {
                                  if (selectedMap != null) {
                                    dataProvider.dropDownOnChanged(selectedMap);
                                  }
                                },
                              ),
                            ),
                          ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        children: [
                          _showLabel('Packs/batch'),
                          CustomTextField(
                            controller: dataProvider.packsController,
                            hintText: 'e.g 10',
                            action: TextInputAction.next,
                            textInputType: TextInputType.number,
                            isFocus: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        children: [
                          _showLabel('Pieces/pack'),
                          CustomTextField(
                            controller: dataProvider.pieceController,
                            hintText: 'e.g 100',
                            action: TextInputAction.next,
                            textInputType: TextInputType.number,
                            isFocus: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _showLabel('Rejection Tolerance'),
                CustomTextField(
                  controller: dataProvider.toleranceController,
                  hintText: 'e.g 0.04',
                  action: TextInputAction.done,
                  textInputType: TextInputType.number,
                  isFocus: false,
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
                child: customButton(context, 'Save', 52, double.infinity),
              ),
            ),
          ),
        ),
      );
    });
  }
}

_showLabel(String txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        !txt.contains('/')
            ? Text(
                txt,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Row(
                children: [
                  Text(
                    '${txt.split('/')[0]}/',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    txt.split('/')[1],
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
      ],
    ),
  );
}
