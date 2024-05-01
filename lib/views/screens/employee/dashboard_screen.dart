import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:industrial_watch/views/screens/employee/pages/home_screen.dart';
import 'package:industrial_watch/views/screens/employee/pages/profile_screen.dart';
import 'package:industrial_watch/views/screens/employee/pages/violations_screen.dart';

import 'pages/attendance_screen.dart';
import 'pages/summary_screen.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  List<String> icons = [
    'assets/icons/navbar_icons/home.svg',
    'assets/icons/navbar_icons/attendance.svg',
    'assets/icons/navbar_icons/summary.svg',
    'assets/icons/navbar_icons/violations.svg',
    'assets/icons/navbar_icons/profile.svg',
  ];

  final List<Widget> _pages = [
    const EmployeeHomeScreen(),
    const EmployeeAttendanceScreen(),
    const EmployeeSummaryScreen(),
    const EmployeeViolationsScreen(),
    const EmployeeProfileScreen(),
  ];

  int _currentIndex = 0;
  double height = double.infinity;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Employee Dashboard'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         logoutDialogBox(
      //             context,
      //             () => Provider.of<EmployeeViewModel>(context, listen: false)
      //                 .logout(context));
      //       },
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      body: _pages.elementAt(_currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Container(
          height: height,
          width: height,
          padding: const EdgeInsets.all(17),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff2E81FE),
                  Color(0xff184EA0),
                ]),
          ),
          child: SvgPicture.asset(
            'assets/icons/navbar_icons/summary.svg',
            alignment: Alignment.center,
          ),
        ),
        onPressed: () {
          setState(() {
            _currentIndex = 2;
            height = 20;
            height = double.infinity;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6.0,
        child: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: icons
              .map(
                (e) => BottomNavigationBarItem(
                  label: e.split('/').last.split('.')[0].toUpperCase(),
                  icon: SvgPicture.asset(
                    e,
                    height: 24,
                    alignment: Alignment.center,
                    color: (icons[_currentIndex] == e)
                        ? (_currentIndex != 2)
                            ? const Color(0xff2E81FE)
                            : Colors.transparent
                        : (icons[2] == e)
                            ? Colors.transparent
                            : null,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
