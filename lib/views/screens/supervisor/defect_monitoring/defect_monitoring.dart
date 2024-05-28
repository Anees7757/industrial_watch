import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/view-models/supervisor/defect_monitoring_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_appbar.dart';

class DefectMonitoring extends StatefulWidget {
  const DefectMonitoring({Key? key}) : super(key: key);

  @override
  State<DefectMonitoring> createState() => _DefectMonitoringState();
}

class _DefectMonitoringState extends State<DefectMonitoring> {
  @override
  void initState() {
    Provider.of<DefectMonitoringViewModel>(context, listen: false)
        .getProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DefectMonitoringViewModel>(
        builder: (context, viewmodel, child) {
      return Scaffold(
        appBar: customAppBar(context, 'Defect Monitoring'),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _showLabel('Product Name'),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 5),
                    width: double.infinity,
                    color: const Color(0xFFDDDDDD).withOpacity(0.5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, dynamic>>(
                        isExpanded: true,
                        icon: Visibility(
                            visible: viewmodel.products.isEmpty ? false : true,
                            child: Icon(Icons.arrow_drop_down)),
                        hint: Provider.of<DefectMonitoringViewModel>(context,
                                    listen: true)
                                .productLoading
                            ? const Text('Loading...')
                            : viewmodel.products.isEmpty
                                ? const Text('No Product Found')
                                : const Text('-- Select Product --'),
                        value: viewmodel.selectedProduct.isNotEmpty
                            ? viewmodel.selectedProduct
                            : null,
                        items: viewmodel.products
                            .map<DropdownMenuItem<Map<String, dynamic>>>((map) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: map,
                            child: Text(map['name']),
                          );
                        }).toList(),
                        onChanged: (Map<String, dynamic>? selectedMap) {
                          if (selectedMap != null) {
                            viewmodel.dropDownOnChanged1(context, selectedMap);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                _showLabel('Batch Number'),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 5),
                    width: double.infinity,
                    color: const Color(0xFFDDDDDD).withOpacity(0.5),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Map<String, dynamic>>(
                        isExpanded: true,
                        icon: Visibility(
                            visible: viewmodel.batches.isEmpty ? false : true,
                            child: Icon(Icons.arrow_drop_down)),
                        hint: Provider.of<DefectMonitoringViewModel>(context,
                                    listen: true)
                                .batchLoading
                            ? const Text('Loading...')
                            : viewmodel.batches.isEmpty
                                ? const Text('No Batch Found')
                                : const Text('-- Select Batch --'),
                        value: viewmodel.selectedBatch.isNotEmpty
                            ? viewmodel.selectedBatch
                            : null,
                        items: viewmodel.batches
                            .map<DropdownMenuItem<Map<String, dynamic>>>((map) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: map,
                            child: Text(map['batch_number']),
                          );
                        }).toList(),
                        onChanged: (Map<String, dynamic>? selectedMap) {
                          if (selectedMap != null) {
                            viewmodel.dropDownOnChanged2(selectedMap);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                (viewmodel.selectedBatch.isNotEmpty &&
                        viewmodel.selectedProduct.isNotEmpty)
                    ? InkWell(
                        onTap: () async {
                          if (viewmodel.imageFileList!.isNotEmpty) {
                            viewmodel.showBottomSheet(context);
                          } else {
                            viewmodel.selectImages(context);
                          }
                        },
                        child: customButton(context, 'Choose Images', 50, 180),
                      )
                    : SizedBox(),
                SizedBox(height: 15),
                (viewmodel.selectedBatch.isNotEmpty &&
                        viewmodel.selectedProduct.isNotEmpty)
                    ? InkWell(
                        onTap: () {
                          viewmodel.processImages(context);
                        },
                        child: customButton(context, 'Upload Images', 50, 180),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      );
    });
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
}
