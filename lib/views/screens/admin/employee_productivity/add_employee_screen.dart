import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/addEmployee_viewmodel.dart';
import 'package:industrial_watch/views/widgets/custom_Button.dart';
import 'package:industrial_watch/views/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

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
      isFirstTime = false;
      fetchData();
    }
  }

  fetchData() async {
    await Future.wait([
      provider!.getSections(context),
      provider!.getRoles(context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {
        provider!.clearControllers();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Employee'),
          automaticallyImplyLeading: true,
          elevation: 0.0,
        ),
        body:
            Consumer<AddEmployeeViewModel>(builder: (context, provider, child) {
          return ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Container(
                // margin: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              color: Colors.blue,
                            ),
                            // child: ClipRRect(
                            // child: SvgPicture.asset(
                            //   fit: BoxFit.cover,
                            //   'assets/images/dashboard_box.svg',
                            //   alignment: Alignment.topCenter,
                            // ),
                            // child: CustomPaint(
                            //   painter: SemicirclePainter(),
                            //   child: SizedBox.expand(),
                            // ),
                          ),
                          Positioned(
                            top: 30,
                            child: GestureDetector(
                              onTap: () {
                                if (provider.imageFileList!.isNotEmpty) {
                                  provider.showBottomSheet(context);
                                } else {
                                  provider.selectImages(context);
                                }
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
                                  child: Provider.of<AddEmployeeViewModel>(
                                                  context,
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
                            controller: provider.usernameController,
                            hintText: 'Username',
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
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: provider.salaryController,
                            hintText: 'Salary',
                            action: TextInputAction.next,
                            textInputType: TextInputType.number,
                            isFocus: false,
                          ),
                          Container(
                            height: 56.79,
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Visibility(
                                      visible: provider.sections.isEmpty
                                          ? false
                                          : true,
                                      child: Icon(Icons.arrow_drop_down)),
                                  value: provider.selectedSection.isNotEmpty
                                      ? provider.selectedSection
                                      : null,
                                  hint: Provider.of<AddEmployeeViewModel>(
                                              context,
                                              listen: true)
                                          .loadingSections
                                      ? const Text('loading...')
                                      : provider.sections.isEmpty
                                          ? const Text('No section found')
                                          : const Text('-- Select Section --'),
                                  items: provider.sections
                                      .map<
                                          DropdownMenuItem<
                                              Map<String, dynamic>>>(
                                        (e) => DropdownMenuItem<
                                            Map<String, dynamic>>(
                                          value: e,
                                          child: Text(
                                            e['name'],
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (Map<String, dynamic>? item) {
                                    if (item != null) {
                                      provider.sectionDropDownOnChanged(item);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 56.79,
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                            ),
                            child: Center(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  icon: Visibility(
                                      visible: provider.sections.isEmpty
                                          ? false
                                          : true,
                                      child: Icon(Icons.arrow_drop_down)),
                                  value: provider.selectedRole.isNotEmpty
                                      ? provider.selectedRole
                                      : null,
                                  hint: Provider.of<AddEmployeeViewModel>(
                                              context,
                                              listen: true)
                                          .loadingRoles
                                      ? const Text('loading...')
                                      : provider.sections.isEmpty
                                          ? const Text('No role found')
                                          : const Text('-- Select Role --'),
                                  items: provider.roles
                                      .map<
                                          DropdownMenuItem<
                                              Map<String, dynamic>>>(
                                        (e) => DropdownMenuItem<
                                            Map<String, dynamic>>(
                                          value: e,
                                          child: Text(
                                            e['name'],
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (Map<String, dynamic>? item) {
                                    if (item != null) {
                                      provider.rolesDropDownOnChanged(item);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gender',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Job Type',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20),
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
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BottomAppBar(
                      child: SizedBox(
                        height: 80,
                        child: Center(
                          child: GestureDetector(
                            onTap: () => provider.addEmployee(context),
                            child: customButton(context, 'Add', 50, 150),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        // bottomNavigationBar:
      ),
    );
  }
}
