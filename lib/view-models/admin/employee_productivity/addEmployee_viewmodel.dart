import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/global/global.dart';

import '../../../models/employee_model.dart';
import '../../../views/widgets/custom_snackbar.dart';

class AddEmployeeViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String selectedSection = '';
  String selectedRole = '';
  String selectedGender = 'gender';
  String selectedJobType = 'jobType';

  List<String> sections = ['Select Section', 'Manufacturing', 'Packing'];
  List<String> roles = ['Select Role', 'Manager', 'Worker'];
  List<String> genders = ['Male', 'Female'];
  List<String> jobTypes = ['Full Time', 'Part Time'];

  initSectionAndRole() {
    selectedSection = sections.first;
    selectedRole = roles.first;
  }

  changeData(List<String> items, item) {
    if (items.first == sections.first) {
      selectedSection = item!;
    } else {
      selectedRole = item!;
    }
    print(item);
    notifyListeners();
  }

  addEmployee(context) {
    Employee emp = Employee(
      name: nameController.text,
      section: selectedSection,
      imageUrl: 'image!.path',
      email: emailController.text,
      password: passwordController.text,
      gender: selectedGender,
      jobType: selectedJobType,
      role: selectedRole,
    );

    employees.add(emp);

    customSnackBar(context, '${emp.name}\'s data inserted');
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    selectedSection = sections.first;
    selectedRole = roles.first;
    selectedGender = 'gender';
    selectedJobType = 'jobType';
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
