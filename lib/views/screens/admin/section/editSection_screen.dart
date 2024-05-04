import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:industrial_watch/view-models/admin/section/editSection_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/custom_timePIcker.dart';

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
    print(widget.section);
    _editSectionViewModel =
        Provider.of<EditSectionViewModel>(context, listen: false);
    _editSectionViewModel!.sectionController.text = widget.section['name'];
    getRules();
    super.initState();
  }

  getRules() async {
    await _editSectionViewModel!.getRules(context);
    await _editSectionViewModel!.getSectionRules(context, widget.section['id']);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (pop) {
        _editSectionViewModel!.sectionController.clear();
        _editSectionViewModel!.selectedRules.clear();
        _editSectionViewModel!.fineController.clear();
        _editSectionViewModel!.selectedTime.clear();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Edit Section'),
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
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
                                    _editSectionViewModel!.rules[index]['name'],
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    )),
                                trailing: Checkbox(
                                  value: _editSectionViewModel!.checkboxValues[
                                      _editSectionViewModel!.rules[index]
                                          ['name']],
                                  onChanged: (newValue) {
                                    _editSectionViewModel!
                                        .checkboxHandle(newValue!, index);
                                    setState(() {});
                                  },
                                ),
                                subtitle: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 90, 5),
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
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                        const Text("Allowed Time: "),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 30, 5),
                                            child: TextField(
                                              readOnly: true,
                                              inputFormatters: [
                                                MaskedInputFormatter('##:##'),
                                                LengthLimitingTextInputFormatter(
                                                    5),
                                              ],
                                              onTap: () async {
                                                if (_editSectionViewModel!
                                                        .checkboxValues.values
                                                        .elementAt(index) ==
                                                    true) {
                                                  String val =
                                                      await customTimePicker(
                                                          context,
                                                          _editSectionViewModel!
                                                              .selectedTime[
                                                                  index]
                                                              .text);

                                                  if (val.isNotEmpty) {
                                                    _editSectionViewModel!
                                                        .selectedTime[index]
                                                        .text = val;
                                                  }
                                                }
                                              },
                                              controller: _editSectionViewModel!
                                                  .selectedTime[index],
                                              decoration: InputDecoration(
                                                enabled: _editSectionViewModel!
                                                            .checkboxValues
                                                            .values
                                                            .elementAt(index) ==
                                                        true
                                                    ? true
                                                    : false,
                                                hintText: 'hh:mm',
                                                filled: true,
                                                fillColor:
                                                    const Color(0xFFF2F2F2),
                                                border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xFFB2B2B2)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
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
      ),
    );
  }
}
