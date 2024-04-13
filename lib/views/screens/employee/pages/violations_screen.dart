import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/models/violation_model.dart';

import 'violations_detail.dart';

class EmployeeViolationsScreen extends StatefulWidget {
  const EmployeeViolationsScreen({super.key});

  @override
  State<EmployeeViolationsScreen> createState() =>
      _EmployeeViolationsScreenState();
}

class _EmployeeViolationsScreenState extends State<EmployeeViolationsScreen> {
  List<Violation>? violation;

  @override
  void initState() {
    super.initState();
    violation = violations
        .where((element) => element.empId == employees[2].id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Violations'),
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
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: (violation!.isEmpty)
            ? const Center(
                child: Text('No Violation Found'),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: violation!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViolationDetailScreen(
                                  violationId: violation![index].id!,
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
                                image: AssetImage(
                                  violation![index].images[0],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            violation![index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Text(violation![index].time),
                              Text(violation![index].date),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
