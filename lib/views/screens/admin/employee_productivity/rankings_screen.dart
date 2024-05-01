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
  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      provider = Provider.of<EmployeesRankingViewModel>(context);
      isFirstTime = false;
      fetchData();
    }
  }

  fetchData() async {
    await Future.wait([
      provider!.getSections(context),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees Ranking'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Provider.of<EmployeesRankingViewModel>(context, listen: true)
              .loadingSections
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Consumer<EmployeesRankingViewModel>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      Container(
                        height: 56.79,
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFDDDDDD).withOpacity(0.5),
                        ),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              icon: Visibility(
                                  visible:
                                      provider.sections.isEmpty ? false : true,
                                  child: Icon(Icons.arrow_drop_down)),
                              value: provider.selectedSection.isNotEmpty
                                  ? provider.selectedSection
                                  : null,
                              hint: Provider.of<EmployeesRankingViewModel>(
                                          context,
                                          listen: true)
                                      .loadingSections
                                  ? const Text('loading...')
                                  : provider.sections.isEmpty
                                      ? const Text('No section found')
                                      : const Text('-- Select Section --'),
                              items: provider.sections
                                  .map<DropdownMenuItem<Map<String, dynamic>>>(
                                    (e) =>
                                        DropdownMenuItem<Map<String, dynamic>>(
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
                                  provider.sectionDropDownOnChanged(item);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: employees.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
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
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                                    trailing: Text(
                                        '${employees[index].productivity}%'),
                                  ),
                                  Divider(
                                    height: 5,
                                  ),
                                ],
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
