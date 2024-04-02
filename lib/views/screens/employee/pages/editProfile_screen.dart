import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/view-models/employee/editProfile_viewmodel.dart';
import 'package:industrial_watch/views/widgets/custom_Button.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  int empId;

  EditProfileScreen({super.key, required this.empId});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileViewModel? pro;
  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    if (isFirstTime) {
      pro = Provider.of<EditProfileViewModel>(context);
      pro!.image = null;
      pro!.nameController.text =
          employees.where((element) => element.id == widget.empId).first.name;
      pro!.emailController.text =
          employees.where((element) => element.id == widget.empId).first.email;
      pro!.passwordController.text = employees
          .where((element) => element.id == widget.empId)
          .first
          .password;
      isFirstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Edit Profile'),
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  provider.showBottomSheet(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  radius: 63,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFF2E81FE).withOpacity(0.7),
                    radius: 60,
                    foregroundImage: provider.image == null
                        ? null
                        : FileImage(provider.image!),
                    child: provider.image == null
                        ? const Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                controller: provider.nameController,
                hintText: 'Name',
                action: TextInputAction.next,
                textInputType: TextInputType.text,
                isFocus: false,
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                controller: provider.emailController,
                hintText: 'Email',
                action: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                isFocus: false,
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 5),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CustomTextField(
                controller: provider.passwordController,
                hintText: 'Password ',
                action: TextInputAction.next,
                textInputType: TextInputType.text,
                isFocus: false,
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: customButton(context, 'Update Profile', 50, 211),
            ),
          ),
        ),
      );
    });
  }
}
