import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../view-models/admin/section/sections_viewmodel.dart';
import '../../../../view-models/admin/supervisor/addSupervisor_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_textfield.dart';

class AddSupervisorScreen extends StatefulWidget {
  const AddSupervisorScreen({super.key});

  @override
  State<AddSupervisorScreen> createState() => _AddSupervisorScreenState();
}

class _AddSupervisorScreenState extends State<AddSupervisorScreen> {
  AddSupervisorViewModel? _addSupervisorViewModel;

  @override
  void initState() {
    _addSupervisorViewModel =
        Provider.of<AddSupervisorViewModel>(context, listen: false);
    _addSupervisorViewModel!.selected.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Add Supervisor'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 50, 15, 0),
        child: Column(
          children: [
            CustomTextField(
              controller: _addSupervisorViewModel!.nameController,
              hintText: 'Name',
              action: TextInputAction.next,
              textInputType: TextInputType.text,
              isFocus: true,
            ),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _addSupervisorViewModel!.usernameController,
                hintText: 'Username',
                action: TextInputAction.next,
              textInputType: TextInputType.text,
              isFocus: false,
            ),
            const SizedBox(height: 10),
            CustomTextField(
                controller: _addSupervisorViewModel!.passwordController,
                hintText: 'Password ',
                action: TextInputAction.next,
              textInputType: TextInputType.text,
              isFocus: false,
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 5),
                width: double.infinity,
                // height: 56.79,
                color: const Color(0xFFDDDDDD).withOpacity(0.5),
                child: DropDownMultiSelect(
                  onChanged: (List<String> x) =>
                      _addSupervisorViewModel!.dropDownOnChanged(x),
                  options: Provider.of<SectionsViewModel>(context).sections,
                  selectedValues: _addSupervisorViewModel!.selected,
                  whenEmpty: 'Select Section/s',
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 0),
                  ),
                  selected_values_style:
                      const TextStyle(fontSize: 16, color: Color(0xFF616161)),
                  hintStyle:
                      const TextStyle(fontSize: 14, color: Color(0xFF616161)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            onTap: () {
              _addSupervisorViewModel!.createAccount(context);
              _addSupervisorViewModel!.selected.clear();
              //dialog box
            },
            child:
                customButton(context, 'Create Account', 56.79, double.infinity),
          ),
        ),
      ),
    );
  }
}
