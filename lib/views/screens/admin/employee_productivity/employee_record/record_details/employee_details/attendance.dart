import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  int employeeId;

  AttendanceScreen({super.key, required this.employeeId});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
        title: const Text('Usama Fayyaz'),
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
