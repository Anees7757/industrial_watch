import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../global/global.dart';
import '../../../../view-models/admin/employee_productivity/ranking_viewmodel.dart';

class EmployeesRankingScreen extends StatefulWidget {
  const EmployeesRankingScreen({super.key});

  @override
  State<EmployeesRankingScreen> createState() => _EmployeesRankingScreenState();
}

class _EmployeesRankingScreenState extends State<EmployeesRankingScreen> {
  EmployeesRankingViewModel? provider;
  List<String> sections = ['All Sections'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<EmployeesRankingViewModel>(context);
    sections.addAll(employees.map((e) => e.section).toList().toSet().toList());
    provider!.selectedSection = sections.first;
  }

  customDropDown() {
    return Container(
      height: 56.79,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFDDDDDD).withOpacity(0.5),
      ),
      child: Center(
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          value: provider!.selectedSection,
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
            provider!.selectedSection = item!;
            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees Ranking'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Consumer<EmployeesRankingViewModel>(
          builder: (context, provider, child) {
            return Column(
              children: [
                customDropDown(),
                Expanded(
                  child: ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          horizontalTitleGap: 5,
                          leading: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 50,
                                width: 68,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 23,
                                  foregroundImage: AssetImage(
                                    employees[index].imageUrl,
                                  ),
                                ),
                              ),
                              (index < 3)
                                  ? Image.asset(
                                      'assets/icons/rank/${index + 1}.png',
                                      height: 30,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          title: Text(employees[index].name),
                          trailing: Text('${employees[index].productivity}%'),
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
