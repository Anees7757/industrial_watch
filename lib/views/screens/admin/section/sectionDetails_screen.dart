import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/section/sectionDetails_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';
import 'editSection_screen.dart';

class SectionDetailsScreen extends StatefulWidget {
  Map<String, dynamic> section;

  SectionDetailsScreen({Key? key, required this.section}) : super(key: key);

  @override
  State<SectionDetailsScreen> createState() => _SectionDetailsScreenState();
}

class _SectionDetailsScreenState extends State<SectionDetailsScreen> {
  late SectionDetailViewModel _sectionDetailViewModel;

  @override
  void initState() {
    super.initState();
    _sectionDetailViewModel =
        Provider.of<SectionDetailViewModel>(context, listen: false);
    fetchData();
  }

  fetchData() async {
    await _sectionDetailViewModel.fetchData(context, widget.section['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.section['name']),
        automaticallyImplyLeading: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Provider.of<SectionDetailViewModel>(context, listen: true).loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rules Included',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _sectionDetailViewModel.rules['rules'].length,
                      itemBuilder: (BuildContext context, int index) {
                        final rule =
                            _sectionDetailViewModel.rules['rules'][index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                              title: Text(
                                rule['rule_name'],
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                "Allowed Time: ${rule['allowed_time']}",
                              ),
                              trailing: Text(
                                'Rs. ${rule['fine']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (index !=
                                _sectionDetailViewModel.rules['rules'].length -
                                    1)
                              const Divider(
                                color: Color(0xFFB7B7B7),
                                thickness: 1,
                                height: 5,
                              )
                            else
                              const SizedBox(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      EditSectionScreen(section: widget.section),
                ),
              );
            },
            child: customButton(context, 'Edit Section', 50, 211),
          ),
        ),
      ),
    );
  }
}
