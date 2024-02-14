import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/views/screens/employee/pages/editProfile_screen.dart';
import 'package:industrial_watch/views/widgets/logout_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../view-models/admin/admin_viewmodel.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({super.key});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditProfileScreen(empId: employees[2].id!),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 180,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(500),
                      bottomRight: Radius.circular(500),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 63,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF2E81FE).withOpacity(0.7),
                      radius: 60,
                      backgroundImage: AssetImage(employees[2].imageUrl),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            employees[2].name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            employees[2].role,
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
                  icon: Icons.email_rounded,
                  title: employees[2].email,
                ),
                customContainer(
                  context: context,
                  icon: Icons.factory_rounded,
                  title: employees[2].section,
                ),
                customContainer(
                  context: context,
                  icon: Icons.work_history_rounded,
                  title: employees[2].jobType,
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
                          Provider.of<AdminViewModel>(context, listen: false)
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
      ),
    );
  }
}

Widget customContainer(
    {required BuildContext context,
    required IconData icon,
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
        Icon(
          icon,
          color:
              title == 'Logout' ? Colors.red : Theme.of(context).primaryColor,
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
