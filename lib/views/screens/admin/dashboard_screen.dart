import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:industrial_watch/views/widgets/custom_snackbar.dart';
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
  void dispose() {
    Provider.of<AdminViewModel>(context, listen: false);
    super.dispose();
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
      backgroundColor: const Color(0xFFF7F7F7),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text('Welcome,',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 5),
                    Text('Muhammad Ali',
                        style: TextStyle(
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
