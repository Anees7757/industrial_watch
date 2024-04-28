import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../view-models/admin/supervisor/editSupervisor_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_textfield.dart';

class EditSupervisorScreen extends StatefulWidget {
  Map<String, dynamic> supervisor;
  EditSupervisorScreen({super.key, required this.supervisor});

  @override
  State<EditSupervisorScreen> createState() => _EditSupervisorScreenState();
}

class _EditSupervisorScreenState extends State<EditSupervisorScreen> {
  EditSupervisorViewModel? _addSupervisorViewModel;

  @override
  void initState() {
    _addSupervisorViewModel =
        Provider.of<EditSupervisorViewModel>(context, listen: false);
    _addSupervisorViewModel!.selectedSections.clear();
    _addSupervisorViewModel!.nameController.text =
        widget.supervisor['employee_name'];
    _addSupervisorViewModel!
        .getSupervisorSections(context, widget.supervisor['employee_id']);
    _addSupervisorViewModel!.getAllSections(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Edit Supervisor"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Provider.of<EditSupervisorViewModel>(context, listen: true).loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                children: [
                  _showLabel('Name'),
                  CustomTextField(
                    controller: _addSupervisorViewModel!.nameController,
                    hintText: 'Name',
                    action: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isFocus: false,
                  ),
                  const SizedBox(height: 10),
                  _showLabel('Username'),
                  CustomTextField(
                    controller: _addSupervisorViewModel!.usernameController,
                    hintText: 'Username',
                    action: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isFocus: false,
                  ),
                  const SizedBox(height: 10),
                  _showLabel('Password'),
                  CustomTextField(
                    controller: _addSupervisorViewModel!.passwordController,
                    hintText: 'Password ',
                    action: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isFocus: false,
                  ),
                  const SizedBox(height: 10),
                  _showLabel('Section/s'),
                  Provider.of<EditSupervisorViewModel>(context, listen: true)
                          .loading
                      ? buildContainer('Loading...')
                      : (Provider.of<EditSupervisorViewModel>(context,
                                  listen: true)
                              .sections
                              .isEmpty)
                          ? buildContainer('No Section Available')
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                width: double.infinity,
                                // height: 56.79,
                                color: const Color(0xFFDDDDDD).withOpacity(0.5),
                                child: DropDownMultiSelect(
                                  onChanged: (List<String> x) =>
                                      _addSupervisorViewModel!
                                          .dropDownOnChanged(x),
                                  options: Provider.of<EditSupervisorViewModel>(
                                          context)
                                      .sections
                                      .map((e) => e['name'] as String)
                                      .toList(),
                                  selectedValues:
                                      _addSupervisorViewModel!.selectedSections,
                                  whenEmpty: 'Select Section/s',
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 0),
                                  ),
                                  selected_values_style: const TextStyle(
                                      fontSize: 16, color: Color(0xFF616161)),
                                  hintStyle: const TextStyle(
                                      fontSize: 14, color: Color(0xFF616161)),
                                ),
                              ),
                            ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            onTap: () {
              _addSupervisorViewModel!
                  .updateSupervisor(context, widget.supervisor['employee_id']);
            },
            child:
                customButton(context, 'Update Supervisor', 52, double.infinity),
          ),
        ),
      ),
    );
  }
}

buildContainer(String msg) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: 56.79,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      width: double.infinity,
      color: const Color(0xFFDDDDDD).withOpacity(0.5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          msg,
          style: const TextStyle(fontSize: 16, color: Color(0xFF616161)),
        ),
      ),
    ),
  );
}

_showLabel(txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      txt,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
