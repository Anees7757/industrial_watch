import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/utils/shared_prefs/shared_prefs.dart';
import 'package:industrial_watch/view-models/employee/profile_viewmodel.dart';
import 'package:industrial_watch/views/screens/employee/pages/editProfile_screen.dart';
import 'package:industrial_watch/views/widgets/logout_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/api_constants.dart';
import '../../../../view-models/admin/admin_viewmodel.dart';
import '../../../widgets/semi_circle.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  ProfileViewModel? _profileViewModel;

  fetchData(int employeeId) async {
    await Future.wait([
      _profileViewModel!.getEmployeeDetail(context, employeeId),
    ]);
  }

  bool isFirstTime = true;
  int? employeeId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _profileViewModel = Provider.of<ProfileViewModel>(context);
      employeeId = jsonDecode(DataSharedPrefrences.getUser())['id'];
      print(employeeId);
      isFirstTime = false;
      fetchData(employeeId!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          !Provider.of<ProfileViewModel>(context, listen: true).loading
              ? Provider.of<ProfileViewModel>(context, listen: true)
                      .employee
                      .isNotEmpty
                  ? IconButton(
                      onPressed: () async {
                        bool value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(
                                employee: _profileViewModel!.employee),
                          ),
                        );
                        if (value) {
                          fetchData(employeeId!);
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.edit),
                    )
                  : SizedBox()
              : SizedBox(),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(builder: (context, provider, child) {
        return Provider.of<ProfileViewModel>(context, listen: true).loading
            ? buildShimmerProfile()
            : provider.employee.isEmpty
                ? Center(child: Text('Something went wrong'))
                : Column(
                    children: [
                      SizedBox(
                        height: 180,
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
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 63,
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color(0xFF2E81FE).withOpacity(0.7),
                                  radius: 60,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${ApiConstants.instance.baseurl}EmployeeImage/${Uri.encodeComponent(provider.employee['image'])}",
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: (context, url) => Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${provider.employee['name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '${provider.employee['username']}',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
                        child: Column(
                          children: [
                            customContainer(
                              context: context,
                              icon: Icons.person,
                              imagePath: 'assets/icons/role.png',
                              title: '${provider.employee['job_role']}',
                            ),
                            customContainer(
                              context: context,
                              icon: Icons.factory_outlined,
                              title: '${provider.employee['section']}',
                            ),
                            customContainer(
                              context: context,
                              icon: Icons.work_history_outlined,
                              title: '${provider.employee['job_type']}',
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    logoutDialogBox(context, () {
                                      Provider.of<AdminViewModel>(context,
                                              listen: false)
                                          .logout(context);
                                    });
                                  },
                                  child: customContainer(
                                    context: context,
                                    icon: Icons.logout_rounded,
                                    title: 'Logout',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
      }),
    );
  }

  Widget customContainer(
      {required BuildContext context,
      required IconData icon,
      String? imagePath,
      required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: title == 'Logout' ? 0 : 4),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFDDDDDD).withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        border: title == 'Logout'
            ? Border.all(color: Colors.grey.shade500)
            : Border.all(color: Colors.transparent, width: 0),
      ),
      child: Row(
        mainAxisAlignment: title == 'Logout'
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: title == 'Logout' ? MainAxisSize.min : MainAxisSize.max,
        children: [
          imagePath == null
              ? Icon(
                  icon,
                  color: title == 'Logout'
                      ? Colors.red
                      : Theme.of(context).primaryColor,
                )
              : Image.asset(
                  imagePath,
                  height: 26,
                  width: 26,
                ),
          const SizedBox(
            width: 9,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: title == 'Logout' ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerProfile() {
    return Column(
      children: [
        SizedBox(
          height: 180,
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
                child: shimmerWrapper(
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 63,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF2E81FE).withOpacity(0.7),
                      radius: 60,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        shimmerWrapper(
          Column(
            children: [
              Container(
                width: 150,
                height: 20,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 15,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            children: [
              shimmerWrapper(customContainer(
                context: context,
                icon: Icons.person,
                imagePath: 'assets/icons/role.png',
                title: '',
              )),
              shimmerWrapper(customContainer(
                context: context,
                icon: Icons.factory_outlined,
                title: '',
              )),
              shimmerWrapper(customContainer(
                context: context,
                icon: Icons.work_history_outlined,
                title: '',
              )),
              const SizedBox(height: 12),
              shimmerWrapper(
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    child: InkWell(
                      onTap: () {},
                      child: customContainer(
                        context: context,
                        icon: Icons.logout_rounded,
                        title: 'Logout',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shimmerWrapper(Widget child) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFDDDDDD),
      highlightColor: Colors.grey.shade400,
      child: child,
    );
  }
}
