import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import '../../repositories/api_repo.dart';
import '../../utils/request_methods.dart';
import '../../views/widgets/custom_dialogbox.dart';
import '../../views/widgets/custom_snackbar.dart';

class DefectMonitoringViewModel extends ChangeNotifier {
  File? image;
  List<XFile>? imageFileList = [];

  Map<String, dynamic> defects_data = {};

  bool _pLoading = true;

  get productLoading => _pLoading;

  setProductLoading(bool value) {
    _pLoading = value;
  }

  bool _bLoading = true;

  get batchLoading => _bLoading;

  setBatchLoading(bool value) {
    _bLoading = value;
  }

  List<dynamic> products = [];
  Map<String, dynamic> selectedProduct = {};
  List<dynamic> batches = [];
  Map<String, dynamic> selectedBatch = {};

  Future<void> getProducts(BuildContext context) async {
    products.clear();
    batches.clear();
    selectedBatch.clear();
    selectedProduct.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetLinkedProducts',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
        setProductLoading(true);
      },
      onSuccess: (data) {
        print('Data Processed');
        print(data);
        products.addAll(data);
        products = products.toSet().toList();
        setProductLoading(false);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        setProductLoading(false);
        notifyListeners();
      },
    );
  }

  Future<void> getBatches(BuildContext context, product_number) async {
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Production/GetAllBatches?product_number=${Uri.encodeComponent(product_number)}',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
        setBatchLoading(true);
      },
      onSuccess: (data) {
        print('Data Processed');
        batches.addAll(data);
        batches = batches.toSet().toList();
        setBatchLoading(false);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        setBatchLoading(false);
        notifyListeners();
      },
    );
  }

  dropDownOnChanged1(BuildContext context, Map<String, dynamic> v) {
    selectedProduct = v;
    print(v);
    selectedBatch.clear();
    batches.clear();
    getBatches(context, v['product_number']);
    notifyListeners();
  }

  dropDownOnChanged2(Map<String, dynamic> v) {
    selectedBatch = v;
    notifyListeners();
  }

  bool isFirstTime = true;

  void selectImages(BuildContext context) async {
    // image = null;
    // imageFileList!.clear();
    if (isFirstTime) {
      final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        if (selectedImages.length >= 5) {
          imageFileList!.addAll(selectedImages);
          if (image == null) {
            final imageTemp = File(selectedImages.first.path);
            this.image = imageTemp;
            showBottomSheet(context);
          }
          print("Image List Length:" + imageFileList!.length.toString());
          isFirstTime = false;
          notifyListeners();
        } else {
          customSnackBar(context, 'Select at least 5 images');
        }
      }
    } else {
      final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
        if (image == null) {
          final imageTemp = File(selectedImages.first.path);
          this.image = imageTemp;
          // showBottomSheet(context);
        }
        print("Image List Length:" + imageFileList!.length.toString());
        notifyListeners();
      }
    }
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      notifyListeners();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  showBottomSheet(context) {
    return showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  onTap: null,
                  title: Text(
                    'Chosen Images',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectImages(context);
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          ...List.generate(
                            Provider.of<DefectMonitoringViewModel>(context,
                                    listen: true)
                                .imageFileList!
                                .length,
                            (index) {
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey),
                                      image: DecorationImage(
                                        image: FileImage(File(Provider.of<
                                                    DefectMonitoringViewModel>(
                                                context,
                                                listen: true)
                                            .imageFileList![index]
                                            .path)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 4, top: 4),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(1),
                                          spreadRadius: 1.5,
                                          blurRadius: 15,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.black,
                                        size: 21,
                                      ),
                                      onTap: () {
                                        imageFileList!.removeAt(index);
                                        if (imageFileList!.isNotEmpty) {
                                          image =
                                              File(imageFileList!.first.path);
                                        } else {
                                          image = null;
                                        }
                                        notifyListeners();
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          if (imageFileList!.isEmpty) SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> processImages(BuildContext context) async {
    if (selectedProduct.isEmpty ||
        selectedBatch.isEmpty ||
        imageFileList!.isEmpty ||
        imageFileList!.length < 5) {
      customSnackBar(
          context, 'Please select a product, batch, and at least 5 image.');
      return;
    }

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

    String productNumber = selectedProduct['product_number'];
    String batchNumber = selectedBatch['batch_number'];
    try {
      List<MultipartFile> imageFiles = [];
      for (XFile file in imageFileList!) {
        imageFiles.add(await MultipartFile.fromFile(file.path));
      }

      FormData formData = FormData.fromMap({
        'product_number': productNumber,
        'batch_number': batchNumber,
        'images': imageFiles,
      });

      Response response = await Dio().post(
        '${ApiConstants.instance.baseurl}Production/DefectMonitoring',
        data: formData,
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        defects_data = response.data;
        customSnackBar(context, 'Images successfully uploaded.');

        showAlertDialog(context, defects_data);
      } else {
        Navigator.pop(context);
        customSnackBar(context, 'Failed to upload images.');
      }
    } catch (e) {
      Navigator.pop(context);
      customSnackBar(context, 'Error: ${e.toString()}');
      print('Error: ${e.toString()}');
    }
  }

  showAlertDialog(BuildContext context, Map<String, dynamic> data) {
    String dataString = "";
    dataString += "Total pieces: ${data['total_items']}\n";
    dataString += "Defected pieces: ${data['total_defected_items']}\n";
    dataString += "\n";
    dataString += "Defects:\n";
    List<dynamic> defects = data['defects'] ?? [];

    for (var defect in defects) {
      defect.forEach((key, value) {
        if (value > 0) {
          dataString += "$key: $value\n";
        }
      });
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Result!"),
          content: Text(dataString),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                imageFileList!.clear();
                // products.clear();
                selectedProduct.clear();
                getProducts(context);
                batches.clear();
                selectedBatch.clear();
                notifyListeners();
              },
            ),
          ],
        );
      },
    );
  }
}
