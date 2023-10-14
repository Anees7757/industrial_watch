import 'package:flutter/material.dart';

import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_textfield.dart';

class EditSectionScreen extends StatefulWidget {
  String section;

  EditSectionScreen({super.key, required this.section});

  @override
  State<EditSectionScreen> createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  TextEditingController sectionController = TextEditingController();

  Map<String, int> rules = {
    'Mobile Usage': 500,
    'Smoking': 300,
    'Gossiping': 200,
  };

  Map<String, bool> checkboxValues = {};

  @override
  void initState() {
    super.initState();
    sectionController.text = widget.section;
    for (var rule in rules.keys) {
      checkboxValues[rule] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Section'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: sectionController,
              hintText: 'Section Name',
              action: TextInputAction.done,
              textInputType: TextInputType.text,
              isFocus: true,
            ),
            const SizedBox(height: 15),
            const Text('Rules',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: rules.length,
                itemBuilder: (BuildContext context, int index) {
                  // TextEditingController fineController = TextEditingController();

                  return Column(
                    children: [
                      ListTile(
                        title: Text(rules.keys.elementAt(index),
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            )),
                        trailing: Checkbox(
                          value: checkboxValues[rules.keys.elementAt(index)],
                          onChanged: (newValue) {
                            setState(() {
                              checkboxValues[rules.keys.elementAt(index)] =
                                  newValue!;
                            });
                          },
                        ),
                        subtitle: Container(
                          padding: const EdgeInsets.fromLTRB(0, 5, 90, 5),
                          child: TextField(
                            //controller: fineController,
                            decoration: InputDecoration(
                                hintText: 'Enter Fine',
                                filled: true,
                                fillColor: const Color(0xFFF2F2F2),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFFB2B2B2)),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                suffixText: ' PKR',
                                suffixStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500)),
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
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
              Navigator.of(context).pop();
            },
            child: customButton(context, 'Confirm Section', 50, 211),
          ),
        ),
      ),
    );
  }
}
