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

class SingleDefectMonitoringViewModel extends ChangeNotifier {
  File? frontImage;
  File? backImage;
  List<File> sideImages = [];
  Map<String, dynamic> result = {};

  Future<void> processImages(BuildContext context) async {
    if (frontImage == null || backImage == null || sideImages.isEmpty) {
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
    try {
      List<MultipartFile> sideImageFiles = [];
      for (File file in sideImages) {
        sideImageFiles.add(await MultipartFile.fromFile(file.path));
      }

      FormData formData = FormData.fromMap({
        'front': await MultipartFile.fromFile(frontImage!.path),
        'back': await MultipartFile.fromFile(backImage!.path),
        'sides': sideImageFiles,
      });

      Response response = await Dio().post(
        '${ApiConstants.instance.baseurl}Production/AnglesMonitoring',
        data: formData,
      );
      if (response.statusCode == 200) {
        result = response.data;
        customSnackBar(context, 'Images successfully uploaded.');
        Navigator.pop(context);
        showAlertDialog(context, result);
      } else {
        customSnackBar(context, 'Failed to upload images.');
        Navigator.pop(context);
      }
    } catch (e) {
      customSnackBar(context, 'Error: ${e.toString()}');
      print('Error: ${e.toString()}');
      Navigator.pop(context);
    }
  }

  Future showAlertDialog(BuildContext context, Map<String, dynamic> data) {
    String status = data['status'];
    Map<String, dynamic> defectsReport = data['defects_report'];

    // Create defect details
    String defectDetails = '';

    if (defectsReport.containsKey('front')) {
      defectDetails += 'Front:\n';
      for (String defect in defectsReport['front']) {
        defectDetails += '  - $defect\n';
      }
    }

    if (defectsReport.containsKey('back')) {
      defectDetails += '\nBack:\n';
      for (String defect in defectsReport['back']) {
        defectDetails += '  - $defect\n';
      }
    }

    if (defectsReport.containsKey('sides')) {
      defectDetails += '\nSides:\n';
      for (var sideDefect in defectsReport['sides']) {
        defectDetails +=
            '  - Side ${sideDefect['side']}: ${sideDefect['defect']}\n';
      }
    }

    // Determine color based on status
    Color statusColor =
        status == 'defected product' ? Colors.red : Colors.green;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 10),
              Text("Defect Report"),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(defectDetails),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                frontImage = null;
                backImage = null;
                sideImages.clear();
                notifyListeners();
              },
            ),
          ],
        );
      },
    );
  }

  clearImages() {
    frontImage = null;
    backImage = null;
    sideImages.clear();
    notifyListeners();
  }
}
