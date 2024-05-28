import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/attendance_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../global/global.dart';
import '../../../../utils/shared_prefs/shared_prefs.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  State<EmployeeAttendanceScreen> createState() =>
      _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {
  AttendanceViewmodel? _attendanceViewmodel;
  int? employeeId;

  fetchData() async {
    await Future.wait([
      _attendanceViewmodel!.getAttendance(context, employeeId!),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _attendanceViewmodel = Provider.of<AttendanceViewmodel>(context);
      employeeId = jsonDecode(DataSharedPrefrences.getUser())['id'];
      isFirstTime = false;
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            jsonDecode(DataSharedPrefrences.getUser())['user_role']
                        .toString()
                        .toLowerCase() ==
                    'employee'
                ? false
                : true,
        title: const Text('Attendance'),
        actions: [
          jsonDecode(DataSharedPrefrences.getUser())['user_role']
                      .toString()
                      .toLowerCase() ==
                  'employee'
              ? CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.blue.shade300,
                  child: Text(
                    userData['name'].toString()[0].toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              : SizedBox(),
          const SizedBox(
            width: 10,
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Consumer<AttendanceViewmodel>(builder: (context, provider, child) {
        return Provider.of<AttendanceViewmodel>(context, listen: true).loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.attendanceList.isEmpty
                ? Center(
                    child: Text('No attendance found'),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DataTable(
                            dataRowMinHeight: 40.0,
                            dataRowMaxHeight: 40.0,
                            sortColumnIndex: 0,
                            dividerThickness: 1.5,
                            border: const TableBorder(
                              //   horizontalInside: BorderSide(width: 1),
                              verticalInside: BorderSide(width: 0.5),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  "Date",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                            rows: provider.attendanceList.reversed
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          e['attendance_date'],
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            e['status'],
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  );
      }),
    );
  }
}
