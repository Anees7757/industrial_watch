import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/global/global.dart';

import '../../models/employee_model.dart';
import '../../views/widgets/custom_snackbar.dart';

class EditProfileViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  addEmployee(context, int id) {
    Employee emp = Employee(
      id: id,
      name: nameController.text,
      section: employees[2].section,
      imageUrl: 'image!.path',
      email: emailController.text,
      password: passwordController.text,
      gender: employees[2].gender,
      jobType: employees[2].jobType,
      role: employees[2].role,
    );

    // employees.removeWhere((element) => element.id == id);
    employees.insert(2, emp);

    customSnackBar(context, '${emp.name}\'s data inserted');
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    image = null;
    print(emp);

    Navigator.pop(context);
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
}
