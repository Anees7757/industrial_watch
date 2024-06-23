import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/views/widgets/custom_snackbar.dart';

import '../../constants/api_constants.dart';
import '../../views/widgets/custom_dialogbox.dart'; // Import your custom snackbar widget here

class MarkAttendanceViewModel extends ChangeNotifier {
  File? selectedImage;

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 6,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                title: Text(
                  'Choose Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                trailing: Icon(
                  Icons.image,
                  color: Colors.grey.shade800,
                  size: 30,
                ),
              ),
              const Divider(
                height: 0,
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                title: Text(
                  'Capture Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
                trailing: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey.shade800,
                  size: 30,
                ),
              ),
              const Divider(
                height: 0,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (selectedImage == null) {
      customSnackBar(context, 'Please select an image first.');
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

    String apiUrl = '${ApiConstants.instance.baseurl}Employee/MarkAttendance';

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(selectedImage!.path),
    });

    try {
      var response = await Dio().post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        Navigator.pop(context);
        var responseData = response.data;
        print('Response: $responseData');
        customSnackBar(context, responseData['message']);
        // Navigator.pop(context);
      } else {
        Navigator.pop(context);
        print('Failed to upload image. Status code: ${response.statusCode}');
        // Handle error scenario, such as showing an error message
        customSnackBar(
            context, 'Failed to upload image. Please try again later.');
      }
    } catch (e) {
      Navigator.pop(context);
      print('Error uploading image: $e');
      // Handle Dio errors or network errors here
      customSnackBar(context, 'Error: ${e}');
    }
  }

  clearSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }
}
