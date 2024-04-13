import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../../view-models/admin/section/addSection_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_textfield.dart';

class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({super.key});

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  AddSectionViewModel? _addSectionViewModel;

  @override
  void initState() {
    _addSectionViewModel =
        Provider.of<AddSectionViewModel>(context, listen: false);
    getRules();
    super.initState();
  }

  getRules() async {
    await _addSectionViewModel!.getRules(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddSectionViewModel>(builder: (context, provider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add Section'),
          automaticallyImplyLeading: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        body: provider.loading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _addSectionViewModel!.sectionController,
                      hintText: 'Section Name',
                      action: TextInputAction.done,
                      textInputType: TextInputType.text,
                      isFocus: true,
                    ),
                    const SizedBox(height: 15),
                    const Text('Rules',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    const SizedBox(height: 5),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _addSectionViewModel!.rules.length,
                        itemBuilder: (BuildContext context, int index) {
                          // TextEditingController fineController = TextEditingController();
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                    _addSectionViewModel!.rules[index]['name'],
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    )),
                                trailing: Checkbox(
                                  value: _addSectionViewModel!.checkboxValues[
                                      _addSectionViewModel!.rules[index]
                                          ['name']],
                                  onChanged: (newValue) {
                                    _addSectionViewModel!
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
                                        controller: _addSectionViewModel!
                                            .fineController[index],
                                        decoration: InputDecoration(
                                            enabled: _addSectionViewModel!
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
                                                _addSectionViewModel!
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
                                                MaskedInputFormatter(
                                                    '##:##:##'),
                                                LengthLimitingTextInputFormatter(
                                                    8),
                                              ],
                                              onChanged: (value) {},
                                              controller: _addSectionViewModel!
                                                  .selectedTime[index],
                                              decoration: InputDecoration(
                                                enabled: _addSectionViewModel!
                                                            .checkboxValues
                                                            .values
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
                              index != _addSectionViewModel!.rules.length - 1
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
                _addSectionViewModel!.addSection(context);
              },
              child: customButton(context, 'Confirm Section', 50, 211),
            ),
          ),
        ),
      );
    });
  }
}
