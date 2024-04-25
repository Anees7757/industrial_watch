import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/addEmployee_viewmodel.dart';
import 'package:industrial_watch/views/widgets/custom_Button.dart';
import 'package:industrial_watch/views/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

import '../../../widgets/semi_circle.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  AddEmployeeViewModel? provider;

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      provider = Provider.of<AddEmployeeViewModel>(context);
      provider!.initSectionAndRole();
      isFirstTime = false;
    }
  }

  customDropDown(List<String> items, String selectedVal) {
    return Container(
      height: 56.79,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFDDDDDD).withOpacity(0.5),
      ),
      child: Center(
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          value: selectedVal,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (item) {
            provider!.changeData(items, item);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        automaticallyImplyLeading: true,
        elevation: 0.0,
      ),
      body: Consumer<AddEmployeeViewModel>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 180),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 0,
                        child: CustomPaint(
                          painter: SemicirclePainter(),
                          child: SizedBox.expand(),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        child: GestureDetector(
                          onTap: () {
                            provider.selectImages(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 63,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color(0xFF2E81FE).withOpacity(0.7),
                              radius: 60,
                              foregroundImage:
                                  Provider.of<AddEmployeeViewModel>(context,
                                                  listen: true)
                                              .image ==
                                          null
                                      ? null
                                      : FileImage(
                                          Provider.of<AddEmployeeViewModel>(
                                                  context,
                                                  listen: true)
                                              .image!),
                              child: Provider.of<AddEmployeeViewModel>(context,
                                              listen: true)
                                          .image ==
                                      null
                                  ? const Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: provider.nameController,
                        hintText: 'Name',
                        action: TextInputAction.next,
                        textInputType: TextInputType.name,
                        isFocus: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: provider.emailController,
                        hintText: 'Email',
                        action: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        isFocus: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: provider.passwordController,
                        hintText: 'Password ',
                        action: TextInputAction.next,
                        textInputType: TextInputType.text,
                        isFocus: false,
                      ),
                      customDropDown(
                          provider.sections, provider.selectedSection),
                      customDropDown(provider.roles, provider.selectedRole),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: provider.genders[0],
                                groupValue: provider.selectedGender,
                                onChanged: (v) {
                                  provider.selectedGender = v!;
                                  setState(() {});
                                },
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: provider.genders[1],
                                groupValue: provider.selectedGender,
                                onChanged: (v) {
                                  provider.selectedGender = v!;
                                  setState(() {});
                                },
                              ),
                              Text(
                                'Female',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Job Type',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: provider.jobTypes[0],
                                groupValue: provider.selectedJobType,
                                onChanged: (v) {
                                  provider.selectedJobType = v!;
                                  setState(() {});
                                },
                              ),
                              Text(
                                'Full Time',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: provider.jobTypes[1],
                                groupValue: provider.selectedJobType,
                                onChanged: (v) {
                                  provider.selectedJobType = v!;
                                  setState(() {});
                                },
                              ),
                              Text(
                                'Part Time',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 80,
          child: Center(
            child: GestureDetector(
              onTap: () => provider!.addEmployee(context),
              child: customButton(context, 'Add', 50, 150),
            ),
          ),
        ),
      ),
    );
  }
}
