import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:provider/provider.dart';

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
  List<XFile>? imageFileList = [];

  void selectImages(BuildContext context) async {
    if (imageFileList!.isNotEmpty) {
      image = null;
      imageFileList!.clear();
    }
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    final imageTemp = File(selectedImages.first.path);
    this.image = imageTemp;
    print("Image List Length:" + imageFileList!.length.toString());
    showBottomSheet(context);
    notifyListeners();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   margin: const EdgeInsets.only(top: 15),
              //   height: 6,
              //   width: 45,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade800,
              //     borderRadius: BorderRadius.circular(50),
              //   ),
              // ),
              // SizedBox(height: 20),
              // ListTile(
              //   onTap: () {
              //     // pickImage(ImageSource.gallery);
              //     selectImages();
              //     Navigator.pop(context);
              //   },
              //   title: Text(
              //     'Choose Photos',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       color: Colors.grey.shade700,
              //     ),
              //   ),
              //   trailing: Icon(
              //     Icons.image,
              //     color: Colors.grey.shade800,
              //     size: 30,
              //   ),
              // ),
              // const Divider(
              //   height: 0,
              // ),
              // ListTile(
              //   onTap: () {
              //     pickImage(ImageSource.camera);
              //     Navigator.pop(context);
              //   },
              //   title: Text(
              //     'Capture Photo',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w500,
              //       color: Colors.grey.shade700,
              //     ),
              //   ),
              //   trailing: Icon(
              //     Icons.camera_alt_outlined,
              //     color: Colors.grey.shade800,
              //     size: 30,
              //   ),
              // ),
              // const Divider(
              //   height: 0,
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              ListTile(
                onTap: null,
                title: Text(
                  'Chosen Photos',
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
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      Provider.of<AddEmployeeViewModel>(context, listen: true)
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
                                image: DecorationImage(
                                  image: FileImage(File(
                                      Provider.of<AddEmployeeViewModel>(context,
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
                                  notifyListeners();
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
