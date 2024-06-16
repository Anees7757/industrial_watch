import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../../../../view-models/supervisor/defect_monitoring_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_appbar.dart';

class SingleDefectMonitoring extends StatefulWidget {
  const SingleDefectMonitoring({super.key});

  @override
  State<SingleDefectMonitoring> createState() => _SingleDefectMonitoringState();
}

class _SingleDefectMonitoringState extends State<SingleDefectMonitoring> {
  File? frontImage;
  File? backImage;
  List<File> sideImages = [];

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _imagePickerBox(context, 'Front', frontImage, () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        frontImage = File(pickedFile.path);
                      });
                    }
                  }),
                  _imagePickerBox(context, 'Back', backImage, () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        backImage = File(pickedFile.path);
                      });
                    }
                  }),
                  _imagePickerBox(context, 'Sides',
                      sideImages.isNotEmpty ? sideImages.first : null,
                      () async {
                    final pickedFiles = await ImagePicker().pickMultiImage();
                    if (pickedFiles != null &&
                        pickedFiles.length + sideImages.length <= 4) {
                      setState(() {
                        sideImages
                            .addAll(pickedFiles.map((file) => File(file.path)));
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('You can only pick up to 4 side images.'),
                        ),
                      );
                    }
                  })
                ],
              ),
              const SizedBox(height: 50),
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
              SizedBox(height: 60),
              // (viewmodel.selectedBatch.isNotEmpty &&
              (frontImage != null &&
                      backImage != null &&
                      sideImages.isNotEmpty &&
                      viewmodel.selectedProduct.isNotEmpty)
                  // )
                  ? InkWell(
                      onTap: () {
                        // viewmodel.processImages(context);
                      },
                      child: customButton(context, 'Upload Images', 50, 180),
                    )
                  : SizedBox()
            ],
          ),
        ),
      );
    });
  }

  Widget _imagePickerBox(
      BuildContext context, String label, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              image: image != null
                  ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                  : null,
            ),
            child: image == null
                ? const Icon(Icons.add_a_photo, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
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
