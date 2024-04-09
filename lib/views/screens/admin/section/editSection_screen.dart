import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:industrial_watch/view-models/admin/section/editSection_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_textfield.dart';

class EditSectionScreen extends StatefulWidget {
  Map<String, dynamic> section;

  EditSectionScreen({super.key, required this.section});

  @override
  State<EditSectionScreen> createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  EditSectionViewModel? _editSectionViewModel;

  @override
  void initState() {
    _editSectionViewModel =
        Provider.of<EditSectionViewModel>(context, listen: false);
    _editSectionViewModel!.sectionController.text = widget.section['name'];
    getRules();
    super.initState();
  }

  getRules() async {
    await _editSectionViewModel!.getRules(context, widget.section['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Section'),
        automaticallyImplyLeading: true,
      ),
      body: Provider.of<EditSectionViewModel>(context, listen: true).loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _editSectionViewModel!.sectionController,
                    hintText: 'Section Name',
                    action: TextInputAction.done,
                    textInputType: TextInputType.text,
                    isFocus: false,
                  ),
                  const SizedBox(height: 15),
                  const Text('Rules',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _editSectionViewModel!.rules.length,
                      itemBuilder: (BuildContext context, int index) {
                        // TextEditingController fineController = TextEditingController();
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                  _editSectionViewModel!.rules[index]
                                      ['rule_name'],
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                              trailing: Checkbox(
                                value: _editSectionViewModel!.checkboxValues[
                                    _editSectionViewModel!.rules[index]
                                        ['rule_name']],
                                onChanged: (newValue) {
                                  _editSectionViewModel!
                                      .checkboxHandle(newValue!, index);
                                  setState(() {});
                                },
                              ),
                              subtitle: Column(
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 90, 5),
                                    child: TextField(
                                      controller: _editSectionViewModel!
                                          .fineController[index],
                                      decoration: InputDecoration(
                                          enabled: _editSectionViewModel!
                                                      .checkboxValues.values
                                                      .elementAt(index) ==
                                                  true
                                              ? true
                                              : false,
                                          hintText: 'Enter Fine',
                                          filled: true,
                                          fillColor: const Color(0xFFF2F2F2),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xFFB2B2B2)),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          suffixText: ' PKR',
                                          suffixStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500)),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      textInputAction: (index !=
                                              _editSectionViewModel!
                                                      .rules.length -
                                                  1)
                                          ? TextInputAction.next
                                          : TextInputAction.done,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text("Time: "),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 5, 80, 5),
                                          child: TextField(
                                            inputFormatters: [
                                              MaskedInputFormatter('##:##:##'),
                                              LengthLimitingTextInputFormatter(
                                                  8),
                                            ],
                                            onChanged: (value) {},
                                            controller: _editSectionViewModel!
                                                .selectedTime[index],
                                            decoration: InputDecoration(
                                              enabled: _editSectionViewModel!
                                                          .checkboxValues.values
                                                          .elementAt(index) ==
                                                      true
                                                  ? true
                                                  : false,
                                              hintText: '00:00:00',
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFFF2F2F2),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xFFB2B2B2)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.black),
                                            cursorColor: Colors.black,
                                            keyboardType:
                                                TextInputType.datetime,
                                            maxLines: 1,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textInputAction:
                                                TextInputAction.done,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            index != _editSectionViewModel!.rules.length - 1
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
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Center(
          child: GestureDetector(
            onTap: () {
              _editSectionViewModel!.addSection(context, widget.section);
            },
            child: customButton(context, 'Confirm Section', 50, 211),
          ),
        ),
      ),
    );
  }
}

//   TextEditingController sectionController = TextEditingController();
//
//   Map<String, int> rules = {
//     'Mobile Usage': 500,
//     'Smoking': 300,
//     'Gossiping': 200,
//   };
//
//   Map<String, bool> checkboxValues = {};
//
//   @override
//   void initState() {
//     super.initState();
//     sectionController.text = widget.section['name'];
//     for (var rule in rules.keys) {
//       checkboxValues[rule] = false;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Edit Section'),
//         automaticallyImplyLeading: true,
//       ),
//       body: Container(
//         margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomTextField(
//               controller: sectionController,
//               hintText: 'Section Name',
//               action: TextInputAction.done,
//               textInputType: TextInputType.text,
//               isFocus: true,
//             ),
//             const SizedBox(height: 15),
//             const Text('Rules',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
//             const SizedBox(height: 5),
//             Expanded(
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: rules.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   // TextEditingController fineController = TextEditingController();
//
//                   return Column(
//                     children: [
//                       ListTile(
//                         title: Text(rules.keys.elementAt(index),
//                             overflow: TextOverflow.visible,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w500,
//                             )),
//                         trailing: Checkbox(
//                           value: checkboxValues[rules.keys.elementAt(index)],
//                           onChanged: (newValue) {
//                             setState(() {
//                               checkboxValues[rules.keys.elementAt(index)] =
//                                   newValue!;
//                             });
//                           },
//                         ),
//                         subtitle: Column(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.fromLTRB(0, 5, 90, 5),
//                               child: TextField(
//                                 //controller: fineController,
//                                 decoration: InputDecoration(
//                                     hintText: 'Enter Fine',
//                                     filled: true,
//                                     fillColor: const Color(0xFFF2F2F2),
//                                     border: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                           color: Color(0xFFB2B2B2)),
//                                       borderRadius: BorderRadius.circular(5.0),
//                                     ),
//                                     suffixText: ' PKR',
//                                     suffixStyle: const TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.w500)),
//                                 style: const TextStyle(color: Colors.black),
//                                 cursorColor: Colors.black,
//                                 keyboardType: TextInputType.number,
//                                 maxLines: 1,
//                                 textAlignVertical: TextAlignVertical.center,
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 const Text("Time: "),
//                                 GestureDetector(
//                                   onTap: () {
//                                     //  _selectTime(context);
//                                   },
//                                   child: Container(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFF2F2F2),
//                                       border: Border.all(
//                                         color: Color(0xFFB2B2B2),
//                                       ),
//                                       borderRadius: BorderRadius.circular(5.0),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         "00:00",
//                                         style: TextStyle(fontSize: 15),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       index != rules.length - 1
//                           ? const Divider(
//                               color: Color(0xFFB7B7B7),
//                               thickness: 1,
//                               height: 5,
//                             )
//                           : const SizedBox(),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SizedBox(
//         height: 80,
//         child: Center(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: customButton(context, 'Confirm Section', 50, 211),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
