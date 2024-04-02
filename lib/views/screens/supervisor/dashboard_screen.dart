import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';
import 'package:provider/provider.dart';

import '../../../global/global.dart';
import '../../../utils/shared_prefs/shared_prefs.dart';
import '../../../view-models/supervisor/supervisor_viewmodel.dart';
import '../../widgets/custom_gridview.dart';
import '../../widgets/logout_dialog.dart';

class SupervisorDashboard extends StatefulWidget {
  const SupervisorDashboard({super.key});

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

class _SupervisorDashboardState extends State<SupervisorDashboard> {
  final List<String> titles = [
    'Employee Monitoring',
    'Defect Monitoring',
    'My Attendance',
  ];

  final List<String> icons = [
    'assets/icons/employee_monitoring.png',
    'assets/icons/defect_monitoring.png',
    'assets/icons/attendance.png',
  ];

  final List<String> navigationVal = [
    'employee_monitoring',
    'before_defect_monitoring',
    'attendance',
  ];
  @override
  void initState() {
    String? userDataString = DataSharedPrefrences.getUser();
    if (userDataString != null && userDataString.isNotEmpty) {
      userData = jsonDecode(userDataString);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      'assets/images/dashboard_box.svg',
      alignment: Alignment.topCenter,
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Supervisor Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              logoutDialogBox(
                  context,
                  () => Provider.of<SupervisorViewModel>(context, listen: false)
                      .logout(context));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            textDirection: TextDirection.ltr,
            children: [
              svg,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text('Welcome,',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 5),
                    Text(userData['name'].toString().capitalize(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          CustomGridView(
            titles: titles,
            navigationVal: navigationVal,
            icons: icons,
            dashboard: 'supervisor',
          ),
        ],
      ),
    );
  }
}
