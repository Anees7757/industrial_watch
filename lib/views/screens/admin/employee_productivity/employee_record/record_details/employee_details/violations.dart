import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/models/violation_model.dart';

import 'violations_detail.dart';

class ViolationsScreen extends StatefulWidget {
  int empId;

  ViolationsScreen({super.key, required this.empId});

  @override
  State<ViolationsScreen> createState() => _ViolationsScreenState();
}

class _ViolationsScreenState extends State<ViolationsScreen> {
  List<Violation>? violation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    violation =
        violations.where((element) => element.empId == widget.empId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employees
            .where((element) => element.id == widget.empId)
            .first
            .name),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: (violation!.isEmpty)
            ? const Center(
                child: Text('No Violation Found'),
              )
            : Column(
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
