import 'package:flutter/material.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/employee_record/record_details/employee_details/attendance.dart';
import 'package:industrial_watch/views/widgets/custom_Button.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../../global/global.dart';
import '../../../../../../models/employee_model.dart';
import 'employee_details/summary.dart';
import 'employee_details/violations.dart';

class EmployeesDetailScreen extends StatefulWidget {
  int empId;

  EmployeesDetailScreen({super.key, required this.empId});

  @override
  State<EmployeesDetailScreen> createState() => _EmployeesDetailScreenState();
}

class _EmployeesDetailScreenState extends State<EmployeesDetailScreen> {
  Employee? employee;

  @override
  void initState() {
    super.initState();
    employee = employees.where((element) => element.id == widget.empId).first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee!.name),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              width: 300,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 0.2,
                      color: Color.fromARGB(30, 0, 169, 181),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${employee!.productivity}%',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('Productivity'),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.1,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: employee!.productivity!.toDouble(),
                        width: 0.2,
                        color: const Color(0xff05F517),
                        // pointerOffset: 0.1,
                        cornerStyle: (employee!.productivity == 100)
                            ? CornerStyle.bothFlat
                            : CornerStyle.bothCurve,
                        sizeUnit: GaugeSizeUnit.factor,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 5,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total Fine',
                    style: TextStyle(),
                  ),
                  Text(
                    '2500',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AttendanceScreen(
                            employeeId: widget.empId,
                          ),
                        ),
                      );
                    },
                    child: customButton(
                        context, 'Attendance', 70, double.infinity)),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViolationsScreen(empId: widget.empId),
                        ),
                      );
                    },
                    child: customButton(
                        context, 'Violations', 70, double.infinity)),
                const SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryScreen(
                            empId: widget.empId,
                          ),
                        ),
                      );
                    },
                    child:
                        customButton(context, 'Summary', 70, double.infinity)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
