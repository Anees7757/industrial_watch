import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/utils/shared_prefs/shared_prefs.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../view-models/admin/admin_viewmodel.dart';
import '../../widgets/custom_gridview.dart';
import '../../widgets/logout_dialog.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<String> titles = [
    'Sections',
    'Supervisors',
    'Employee Productivity',
    'Production'
  ];

  final List<String> icons = [
    'assets/icons/sections.png',
    'assets/icons/supervisors.png',
    'assets/icons/employee_productivity.png',
    'assets/icons/production.png'
  ];

  final List<String> navigationVal = [
    'section',
    'supervisor',
    'productivity',
    'production'
  ];

  @override
  void initState() {
    String? userDataString = DataSharedPrefrences.getUser();
    if (userDataString.isNotEmpty) {
      userData = jsonDecode(userDataString);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      'assets/images/dashboard_box.svg',
      alignment: Alignment.topCenter,
      // colorFilter: ColorFilter.mode(
      //   Theme.of(context).primaryColor,
      //   BlendMode.lighten,
      // ),
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      //backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              logoutDialogBox(
                  context,
                  () => Provider.of<AdminViewModel>(context, listen: false)
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
            dashboard: 'admin',
          ),
        ],
      ),
    );
  }
}
