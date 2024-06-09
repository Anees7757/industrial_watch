import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/summary_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SummaryScreen extends StatefulWidget {
  Map<String, dynamic> employee;

  SummaryScreen({super.key, required this.employee});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  SummaryViewModel? _summaryViewModel;

  fetchData() async {
    await Future.wait([
      _summaryViewModel!.getSummary(context, widget.employee['employee_id']),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _summaryViewModel = Provider.of<SummaryViewModel>(context);
      _summaryViewModel!.selectedMonth = DateTime.now().month;
      _summaryViewModel!.selectedYear = DateTime.now().year;
      _summaryViewModel!.fromSelectedDate =
          '${DateTime.now().month},${DateTime.now().year}';
      isFirstTime = false;
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryViewModel>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.employee['name']),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        body: Provider.of<SummaryViewModel>(context, listen: true).loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.summary.isEmpty
                ? Center(child: Text('Something went wrong'))
                : Container(
                    margin: const EdgeInsets.fromLTRB(20, 25, 20, 40),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Select Month/Year'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            provider.showPicker(context, 'from',
                                widget.employee['employee_id']);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              // borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.calendar_month),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  provider.fromSelectedDate!.isEmpty
                                      ? 'Select month/year'
                                      : '${provider.fromSelectedDate!.split(',')[0]} , ${provider.fromSelectedDate!.split(',')[1]}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text('To'),
                        // ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: IconButton(
                        //     onPressed: () {
                        //       provider.showPicker(context, 'to');
                        //     },
                        //     icon: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         const Icon(Icons.calendar_month),
                        //         const SizedBox(
                        //           width: 10,
                        //         ),
                        //         Text(
                        //           provider.toSelectedDate.isEmpty
                        //               ? 'Select month/year'
                        //               : provider.toSelectedDate,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 200,
                          width: 300,
                          child: SfRadialGauge(axes: <RadialAxis>[
                            RadialAxis(
                              interval: 25,
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${provider.summary['attendance_rate'].toString().split('/')[0]}',
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
                                            '${provider.summary['attendance_rate'].toString().split('/')[1]}',
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
                              maximum:
                                  provider.summary['attendance_rate'] != 'N/A'
                                      ? double.parse(provider
                                          .summary['attendance_rate']
                                          .toString()
                                          .split('/')[1])
                                      : 30,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: const AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Color.fromARGB(30, 0, 169, 181),
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                  value: provider.summary['attendance_rate'] !=
                                          'N/A'
                                      ? double.parse(provider
                                          .summary['attendance_rate']
                                          .toString()
                                          .split('/')[0])
                                      : 0.0,
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
                        customContainer(
                            title: 'Total Fine',
                            value: '${provider.summary['total_fine'].toInt()}'),
                        const SizedBox(
                          height: 15,
                        ),
                        customContainer(
                            title: 'Violations',
                            value: '${provider.summary['violation_count']}'),
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
