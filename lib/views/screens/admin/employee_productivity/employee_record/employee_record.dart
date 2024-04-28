import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employeeRecord_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../../global/global.dart';
import '../../../../widgets/custom_textfield.dart';
import 'record_details/employee_details.dart';

class EmployeeRecordScreen extends StatefulWidget {
  const EmployeeRecordScreen({super.key});

  @override
  State<EmployeeRecordScreen> createState() => _EmployeeRecordScreenState();
}

class _EmployeeRecordScreenState extends State<EmployeeRecordScreen> {
  EmployeeRecordViewModel? _employeeRecordViewModel;

  fetchData() async {
    await Future.wait([
      _employeeRecordViewModel!.getSections(context),
      // _employeeRecordViewModel!.getEmployees(context),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _employeeRecordViewModel = Provider.of<EmployeeRecordViewModel>(context);
      isFirstTime = false;
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Employees Record'),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        // actions: [
        //   PopupMenuButton(
        //     icon: Icon(Icons.sort),
        //     itemBuilder: (context) => [
        //       PopupMenuItem(
        //         height: 30,
        //         padding: EdgeInsets.symmetric(horizontal: 10),
        //         value: 1,
        //         child: Text("High Productivity"),
        //       ),
        //       PopupMenuItem(
        //         height: 0,
        //         child: Divider(),
        //         padding: EdgeInsets.zero,
        //       ),
        //       PopupMenuItem(
        //         height: 30,
        //         padding: EdgeInsets.symmetric(horizontal: 10),
        //         value: 1,
        //         child: Text("Low Productivity"),
        //       ),
        //     ],
        //     offset: Offset(0, 50),
        //     color: Colors.white,
        //     elevation: 2,
        //   ),
        // ],
      ),
      body: Consumer<EmployeeRecordViewModel>(
          builder: (context, provider, child) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 56.79,
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   color: const Color(0xFFDDDDDD).withOpacity(0.5),
                        // ),
                        child: Center(
                          child: DropdownButton(
                            isExpanded: true,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            underline: Divider(
                              color: Colors.white,
                              height: 6,
                              thickness: 1.2,
                            ),
                            icon: Visibility(
                              visible: provider.sections.isEmpty ? false : true,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                            value: provider.selectedSection.isNotEmpty
                                ? provider.selectedSection
                                : null,
                            hint: Provider.of<EmployeeRecordViewModel>(context,
                                        listen: true)
                                    .loadingSections
                                ? const Text(
                                    'loading...',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  )
                                : provider.sections.isEmpty
                                    ? const Text(
                                        'No section found',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      )
                                    : const Text(
                                        'Select Section',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                            items: provider.sections
                                .map<DropdownMenuItem<Map<String, dynamic>>>(
                                  (e) => DropdownMenuItem<Map<String, dynamic>>(
                                    value: e,
                                    child: Text(
                                      e['name'],
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (Map<String, dynamic>? item) {
                              if (item != null) {
                                provider.dropDownOnChanged(item);
                              }
                            },
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: provider.searchController,
                        hintText: 'Search Employee',
                        action: TextInputAction.search,
                        textInputType: TextInputType.text,
                        isFocus: false,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: employees.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmployeesDetailScreen(
                                      empId: employees[index].id!)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: Offset(0, 0),
                                spreadRadius: 0.7,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      employees[index].imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    margin: const EdgeInsets.all(5),
                                    child: Text(
                                      '${employees[index].productivity}%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.amber.shade700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employees[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  employees[index].section,
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      }),
    );
  }
}
