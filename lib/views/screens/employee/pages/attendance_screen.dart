import 'package:flutter/material.dart';

import '../../../../global/global.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  State<EmployeeAttendanceScreen> createState() =>
      _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {
  List<Map<String, dynamic>> attendanceList = [
    {'date': '10 May 2023', 'status': 'P'},
    {'date': '11 May 2023', 'status': 'A'},
    {'date': '12 May 2023', 'status': 'P'},
    {'date': '13 May 2023', 'status': 'P'},
    {'date': '14 May 2023', 'status': 'A'},
    {'date': '15 May 2023', 'status': 'P'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Attendance'),
        actions: [
          CircleAvatar(
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
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        width: double.infinity,
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
              rows: attendanceList
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            e['date'],
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
  }
}
