import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../global/global.dart';
import '../../../../widgets/custom_textfield.dart';
import 'record_details/employee_details.dart';

class EmployeeRecordScreen extends StatefulWidget {
  const EmployeeRecordScreen({super.key});

  @override
  State<EmployeeRecordScreen> createState() => _EmployeeRecordScreenState();
}

class _EmployeeRecordScreenState extends State<EmployeeRecordScreen> {
  customDropDown(List<String> items, String selectedVal) {
    return Container(
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
          value: selectedSection,
          items: sections
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (item) {
            // provider!.changeData(items, item);
            selectedSection = item!;
            setState(() {});
          },
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
      ),
    );
  }

  List<String> sections = ['All Sections', 'Manufacturing', 'Packing'];
  String selectedSection = 'All Sections';
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Employee Record'),
        automaticallyImplyLeading: true,
        elevation: 0.0,
        actions: [
          IconButton(
            splashRadius: 20,
            icon: const Icon(Icons.sort),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
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
                    customDropDown(sections, selectedSection),
                    CustomTextField(
                      controller: searchController,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              spreadRadius: 0.5,
                              blurRadius: 1,
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
      ),
    );
  }
}
