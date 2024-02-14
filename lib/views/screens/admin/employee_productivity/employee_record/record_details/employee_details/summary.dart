import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_details/summary_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SummaryScreen extends StatefulWidget {
  int empId;
  SummaryScreen({super.key, required this.empId});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(employees
              .where((element) => element.id == widget.empId)
              .first
              .name),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('From'),
              ),
              SizedBox(
                width: double.infinity,
                child: IconButton(
                  onPressed: () {
                    provider.showPicker(context, 'from');
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        provider.fromSelectedDate.isEmpty
                            ? 'Select month/year'
                            : provider.fromSelectedDate,
                      ),
                    ],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('To'),
              ),
              SizedBox(
                width: double.infinity,
                child: IconButton(
                  onPressed: () {
                    provider.showPicker(context, 'to');
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        provider.toSelectedDate.isEmpty
                            ? 'Select month/year'
                            : provider.toSelectedDate,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                width: 300,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                    interval: 25,
                    annotations: const <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '25',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '/',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                Text(
                                  '30',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            Text('Presents'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('(Attendance)'),
                          ],
                        ),
                        angle: 90,
                        positionFactor: 0.1,
                      ),
                    ],
                    minimum: 0,
                    maximum: 30,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 0.2,
                      cornerStyle: CornerStyle.bothCurve,
                      color: Color.fromARGB(30, 0, 169, 181),
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: const <GaugePointer>[
                      RangePointer(
                        value: 25,
                        width: 0.2,
                        color: Color(0xff05F517),
                        // pointerOffset: 0.1,
                        cornerStyle: CornerStyle.bothCurve,
                        sizeUnit: GaugeSizeUnit.factor,
                      )
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 30,
              ),
              customContainer(title: 'Total Fine', value: '2500'),
              const SizedBox(
                height: 15,
              ),
              customContainer(title: 'Violations', value: '25'),
            ],
          ),
        ),
      );
    });
  }
}

Widget customContainer({required String title, required String value}) {
  return Container(
    width: double.infinity,
    height: 90,
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
        Text(
          title,
          style: const TextStyle(),
        ),
        !value.contains('/')
            ? Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value.split('/')[0],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '/',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    value.split('/')[1],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
      ],
    ),
  );
}
