import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../global/global.dart';
import '../../../../utils/shared_prefs/shared_prefs.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  @override
  void initState() {
    String? userDataString = DataSharedPrefrences.getUser();
    if (userDataString.isNotEmpty) {
      userData = jsonDecode(userDataString);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(userData['name'].toString().capitalize()),
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
        margin: const EdgeInsets.fromLTRB(20, 30, 20, 80),
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
                              '${employees[2].productivity}%',
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
                        value: employees[2].productivity!.toDouble(),
                        width: 0.2,
                        color: const Color(0xff05F517),
                        // pointerOffset: 0.1,
                        cornerStyle: (employees[2].productivity == 100)
                            ? CornerStyle.bothFlat
                            : CornerStyle.bothCurve,
                        sizeUnit: GaugeSizeUnit.factor,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            customContainer(title: 'Total Fine', value: '2500'),
            customContainer(title: 'Total Attendance', value: '25/30'),
          ],
        ),
      ),
    );
  }
}

Widget customContainer({required String title, required String value}) {
  return Container(
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
