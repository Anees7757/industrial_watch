import 'package:flutter/material.dart';
import 'package:industrial_watch/constants/api_constants.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/violations_viewmodel.dart';
import 'package:provider/provider.dart';

import 'violations_detail.dart';

class ViolationsScreen extends StatefulWidget {
  Map<String, dynamic> employee;

  ViolationsScreen({super.key, required this.employee});

  @override
  State<ViolationsScreen> createState() => _ViolationsScreenState();
}

class _ViolationsScreenState extends State<ViolationsScreen> {
  ViolationsViewModel? _ViolationsViewModel;

  fetchData() async {
    await Future.wait([
      _ViolationsViewModel!
          .getViolations(context, widget.employee['employee_id']),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _ViolationsViewModel = Provider.of<ViolationsViewModel>(context);
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
      body: Consumer<ViolationsViewModel>(builder: (context, provider, child) {
        return Provider.of<ViolationsViewModel>(context, listen: true).loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.violations.isEmpty
                ? const Center(
                    child: Text('No Violation Found'),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Violations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: provider.violations.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViolationDetailScreen(
                                            violationId:
                                                provider.violations[index]
                                                    ['violation_id'],
                                            employeeName:
                                                widget.employee['name'],
                                          ),
                                        ),
                                      );
                                    },
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: provider
                                                  .violations[index]['images']
                                                  .isNotEmpty
                                              ? NetworkImage(
                                                  "${ApiConstants.instance.baseurl}EmployeeViolationImage/${Uri.encodeComponent(provider.violations[index]['images'][0])}",
                                                )
                                              : Center(
                                                  child: Icon(
                                                      Icons.image_outlined),
                                                ) as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      provider.violations[index]['rule_name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 2),
                                        Text(
                                            provider.violations[index]['time']),
                                        Text(
                                            provider.violations[index]['date']),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
      }),
    );
  }
}
