import 'package:flutter/material.dart';
import 'package:industrial_watch/view/screens/admin/section/editSection_screen.dart';

import '../../../widgets/custom_Button.dart';

class SectionDetailsScreen extends StatefulWidget {
  String section;

  SectionDetailsScreen({super.key, required this.section});

  @override
  State<SectionDetailsScreen> createState() => _SectionDetailsScreenState();
}

class _SectionDetailsScreenState extends State<SectionDetailsScreen> {
  Map<String, int> rules = {
    'Mobile Usage': 500,
    'Smoking': 300,
    'Gossiping': 200,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.section),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rules Included',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                )),
            Expanded(
              child: ListView.builder(
                itemCount: rules.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Text('${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18
                            )),
                        title: Text(rules.keys.elementAt(index),
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                        trailing: Text('Rs. ${rules.values.elementAt(index)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      index != rules.length - 1
                          ? const Divider(
                              color: Color(0xFFB7B7B7),
                              thickness: 1,
                              height: 5,
                            )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 100,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditSectionScreen(section: widget.section),
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
