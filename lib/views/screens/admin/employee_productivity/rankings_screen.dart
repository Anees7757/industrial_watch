import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../global/global.dart';
import '../../../../view-models/admin/employee_productivity/ranking_viewmodel.dart';
import '../../../widgets/custom_nodata.dart';

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
      backgroundColor:
          Provider.of<EmployeesRankingViewModel>(context, listen: true)
                  .sections
                  .isEmpty
              ? Colors.white
              : Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Employees Ranking'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.sort),
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 10),
                value: 1,
                child: Text("Descending"),
              ),
              PopupMenuItem(
                height: 0,
                child: Divider(),
                padding: EdgeInsets.zero,
              ),
              PopupMenuItem(
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 10),
                value: 1,
                child: Text("Ascending"),
              ),
            ],
            offset: Offset(0, 50),
            color: Colors.white,
            elevation: 2,
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Provider.of<EmployeesRankingViewModel>(context, listen: true)
              .loadingSections
          ? Center(child: CircularProgressIndicator())
          : Provider.of<EmployeesRankingViewModel>(context, listen: true)
                  .sections
                  .isEmpty
              ? customNoDataWidget()
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
                                      visible: provider.sections.isEmpty
                                          ? false
                                          : true,
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
                                      .map<
                                          DropdownMenuItem<
                                              Map<String, dynamic>>>(
                                        (e) => DropdownMenuItem<
                                            Map<String, dynamic>>(
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

_buildShimmer() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18, 15, 18, 0),
    child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 8,
                leading: Shimmer.fromColors(
                  baseColor: const Color(0xFFDDDDDD),
                  highlightColor: Colors.grey.shade400,
                  child: CircleAvatar(
                    radius: 25,
                  ),
                ),
                title: Shimmer.fromColors(
                  baseColor: const Color(0xFFDDDDDD),
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    height: 10,
                    width: 40,
                    margin: EdgeInsets.only(right: 60),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                trailing: Shimmer.fromColors(
                  baseColor: const Color(0xFFDDDDDD),
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    height: 10,
                    width: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDDDDD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 5,
              ),
            ],
          );
        }),
  );
}
