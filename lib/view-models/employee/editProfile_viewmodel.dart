import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/views/widgets/custom_dialogbox.dart';
import '../../constants/api_constants.dart';
import '../../repositories/api_repo.dart';
import '../../utils/request_methods.dart';
import '../../utils/shared_prefs/shared_prefs.dart';
import '../../views/widgets/custom_snackbar.dart';

class EditProfileViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  updateEmployee(context) async {
    try {
      if (nameController.text.isNotEmpty &&
          usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        int employeeId = jsonDecode(DataSharedPrefrences.getUser())['id'];
        print(employeeId);
        Map<String, dynamic> employeeMap = {
          'id': employeeId,
          'name': nameController.text,
          'username': usernameController.text,
          'password': passwordController.text,
        };
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

        await ApiRepo().apiFetch(
          context: context,
          path: 'Employee/UpdateEmployeeProfile',
          body: employeeMap,
          requestMethod: RequestMethod.PUT,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) {
            print('Data Processed');
            print(data);
            customSnackBar(context, data['message']);
            clearControllers();
            Navigator.pop(context);
            Navigator.pop(context, true);
          },
          onError: (error) {
            print(error.toString());
            Navigator.pop(context);
            customSnackBar(context, error.toString());
          },
        );
      } else {
        customSnackBar(context, 'All fields are required');
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
      customSnackBar(context, e.toString());
    }
  }

  File? image;

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
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
            ListTile(
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              title: Text(
                'Select Photo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              trailing: Icon(
                Icons.photo_album_outlined,
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
              height: 80,
            ),
          ],
        );
      },
    );
  }

  clearControllers() {
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    // image = null;
  }
}
