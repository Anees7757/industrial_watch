import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../view-models/admin/admin_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/logout_dialog.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text('Welcome',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade100)),
          const Text('Muhammad Ali',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white)),
          const SizedBox(height: 80),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, -3),
                    ),
                  ]),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminViewModel>(context, listen: false)
                          .navigate(context, 'section');
                    },
                    child: customButton(
                        context, 'Sections', 78.29, double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminViewModel>(context, listen: false)
                          .navigate(context, 'supervisor');
                    },
                    child: customButton(
                        context, 'Supervisors', 78.29, double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminViewModel>(context, listen: false)
                          .navigate(context, 'productivity');
                    },
                    child: customButton(context, 'Employee Productivity', 78.29,
                        double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Provider.of<AdminViewModel>(context, listen: false)
                          .navigate(context, 'production');
                    },
                    child: customButton(
                        context, 'Production', 78.29, double.infinity),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
