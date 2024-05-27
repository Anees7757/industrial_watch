import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:industrial_watch/constants/api_constants.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/utils/shared_prefs/shared_prefs.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/violations_viewmodel.dart';
import 'package:provider/provider.dart';
import 'violations_detail.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';

class EmployeeViolationsScreen extends StatefulWidget {
  const EmployeeViolationsScreen({super.key});

  @override
  State<EmployeeViolationsScreen> createState() =>
      _EmployeeViolationsScreenState();
}

class _EmployeeViolationsScreenState extends State<EmployeeViolationsScreen> {
  ViolationsViewModel? _ViolationsViewModel;
  int? employeeId;

  fetchData(int employeeId) async {
    await Future.wait([
      _ViolationsViewModel!.getViolations(context, employeeId),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _ViolationsViewModel = Provider.of<ViolationsViewModel>(context);
      employeeId = jsonDecode(DataSharedPrefrences.getUser())['id'];
      isFirstTime = false;
      fetchData(employeeId!);
    }
    super.didChangeDependencies();
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
                                              : AssetImage(
                                                  // provider.violations[index]
                                                  // ['violation_id'][0],
                                                  provider.getDummyImagePath(
                                                    provider.violations[index]
                                                        ['rule_name'],
                                                  ),
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
