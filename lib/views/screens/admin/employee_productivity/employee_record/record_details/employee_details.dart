import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/empolyeeDetail_viewmodel.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/employee_record/record_details/employee_details/attendance.dart';
import 'package:industrial_watch/views/widgets/custom_Button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'employee_details/summary.dart';
import 'employee_details/violations.dart';

class EmployeesDetailScreen extends StatefulWidget {
  Map<String, dynamic> employee;

  EmployeesDetailScreen({super.key, required this.employee});

  @override
  State<EmployeesDetailScreen> createState() => _EmployeesDetailScreenState();
}

class _EmployeesDetailScreenState extends State<EmployeesDetailScreen> {
  EmployeeDetailViewModel? _employeeDetailViewModel;

  fetchData() async {
    await Future.wait([
      _employeeDetailViewModel!
          .getEmployee(context, widget.employee['employee_id']),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _employeeDetailViewModel = Provider.of<EmployeeDetailViewModel>(context);
      isFirstTime = false;
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee['name']),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Consumer<EmployeeDetailViewModel>(
          builder: (context, provider, child) {
        return Provider.of<EmployeeDetailViewModel>(context, listen: true)
                .loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.employee.isEmpty
                ? Center(child: Text('Something went wrong'))
                : Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${(provider.employee['productivity']).toInt()}%',
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
                                    value: provider.employee['productivity'],
                                    width: 0.2,
                                    color: const Color(0xff05F517),
                                    // pointerOffset: 0.1,
                                    cornerStyle:
                                        (provider.employee['productivity'] ==
                                                100.0)
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total Fine',
                                style: TextStyle(),
                              ),
                              Text(
                                '${provider.employee['total_fine'].toInt()}',
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
                                        employee: widget.employee,
                                      ),
                                    ),
                                  );
                                },
                                child: customButton(context, 'Attendance', 65,
                                    double.infinity)),
                            const SizedBox(height: 10),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViolationsScreen(
                                        employee: widget.employee,
                                      ),
                                    ),
                                  );
                                },
                                child: customButton(context, 'Violations', 65,
                                    double.infinity)),
                            const SizedBox(height: 10),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SummaryScreen(
                                        empId: widget.employee['employee_id'],
                                      ),
                                    ),
                                  );
                                },
                                child: customButton(
                                    context, 'Summary', 65, double.infinity)),
                          ],
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
