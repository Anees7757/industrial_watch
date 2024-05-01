import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/contants/api_constants.dart';
import 'package:industrial_watch/views/widgets/custom_dialogbox.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class AddEmployeeViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  Map<String, dynamic> selectedSection = {};
  Map<String, dynamic> selectedRole = {};
  String selectedGender = 'gender';
  String selectedJobType = 'jobType';

  List<dynamic> sections = [];
  List<dynamic> roles = [];
  List<String> genders = ['Male', 'Female'];
  List<String> jobTypes = ['Full Time', 'Part Time'];

  File? image;
  List<XFile>? imageFileList = [];

  bool loadingSections = true;
  bool loadingRoles = true;

  Future<void> getSections(BuildContext context) async {
    isFirstTime = true;
    loadingSections = true;
    sections.clear();
    selectedSection = {};
    await ApiRepo().apiFetch(
      context: context,
      path: 'Section/GetAllSections?status=1',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        for (var i in data) {
          sections.add(i);
        }
        sections = sections.toSet().toList();
        print("Sections >>>>> " + sections.toString());
        loadingSections = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loadingSections = false;
        notifyListeners();
      },
    );
  }

  Future<void> getRoles(BuildContext context) async {
    loadingRoles = true;
    roles.clear();
    selectedRole = {};
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetAllJobRoles',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        for (var i in data) {
          roles.add(i);
        }
        roles = roles.toSet().toList();
        print("Roles >>>>> " + roles.toString());
        loadingRoles = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loadingRoles = false;
        notifyListeners();
      },
    );
  }

  sectionDropDownOnChanged(Map<String, dynamic> item) {
    selectedSection = item;
    notifyListeners();
  }

  rolesDropDownOnChanged(Map<String, dynamic> item) {
    selectedRole = item;
    notifyListeners();
  }

  addEmployee(context) {
    addEmployeeWithImages(
      context: context,
      name: nameController.text,
      password: passwordController.text,
      username: usernameController.text,
      salary: salaryController.text,
      gender: selectedGender,
      jobType: selectedJobType,
      jobRoleId: selectedRole['id'].toString(),
      sectionId: selectedSection['id'].toString(),
      images: imageFileList!,
    );
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
                            Provider.of<AddEmployeeViewModel>(context,
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
                                        image: FileImage(File(
                                            Provider.of<AddEmployeeViewModel>(
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

  Future<void> addEmployeeWithImages({
    required BuildContext context,
    required String name,
    required String salary,
    required String username,
    required String password,
    required String jobRoleId,
    required String jobType,
    required String gender,
    required String sectionId,
    required List<XFile> images,
  }) async {
    // print('Name: $name');
    // print('Salary: $salary');
    // print('Username: $username');
    // print('Password: $password');
    // print('Job Role ID: $jobRoleId');
    // print('Job Type: $jobType');
    // print('Gender: $gender');
    // print('Section ID: $sectionId');
    // print(images);

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
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.instance.baseurl}Employee/AddEmployee'),
      );

      request.fields['name'] = name;
      request.fields['salary'] = salary;
      request.fields['username'] = username;
      request.fields['password'] = password;
      request.fields['job_role_id'] = jobRoleId;
      request.fields['job_type'] = jobType;
      request.fields['gender'] = gender;
      request.fields['section_id'] = sectionId;

      for (var image in images) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = http.MultipartFile(
          'files',
          stream,
          length,
          filename: image.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var message = jsonDecode(responseBody)['message'];
        customSnackBar(context, message);
        clearControllers();
        Navigator.pop(context);
        Navigator.pop(context, true);
      } else {
        var responseBody = await response.stream.bytesToString();
        var message = jsonDecode(responseBody)['message'];
        print(message);
        customSnackBar(context, message);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
      Navigator.pop(context);
      customSnackBar(context, e.toString());
    }
  }

  clearControllers() {
    nameController.clear();
    usernameController.clear();
    passwordController.clear();
    salaryController.clear();
    selectedSection = {};
    selectedRole = {};
    salaryController.clear();
    selectedGender = 'gender';
    selectedJobType = 'jobType';
    imageFileList!.clear();
    image = null;
  }
}
