import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/employee/employee_viewmodel.dart';
import 'package:industrial_watch/view-models/supervisor/supervisor_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../view-models/admin/admin_viewmodel.dart';

class CustomGridView extends StatefulWidget {
  final List<String> titles;
  final List<String> navigationVal;
  final List<String> icons;
  final String dashboard;

  const CustomGridView(
      {super.key,
      required this.titles,
      required this.navigationVal,
      required this.icons,
      required this.dashboard});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: List.generate(widget.titles.length, (index) {
          return InkWell(
            onTap: () {
              if (widget.dashboard == 'admin') {
                Provider.of<AdminViewModel>(context, listen: false)
                    .navigate(context, widget.navigationVal[index]);
              } else if (widget.dashboard == 'supervisor') {
                Provider.of<SupervisorViewModel>(context, listen: false)
                    .navigate(context, widget.navigationVal[index]);
              } else {
                Provider.of<EmployeeViewModel>(context, listen: false)
                    .navigate(context, widget.navigationVal[index]);
              }
            },
            child: Container(
              height: 153,
              width: 153,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 0,
                    color: Colors.black.withOpacity(0.04),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 81,
                    width: 81,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      widget.icons[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                  (widget.titles[index].contains(' '))
                      ? const SizedBox(height: 9)
                      : const SizedBox(height: 18),
                  Text(
                    widget.titles[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
