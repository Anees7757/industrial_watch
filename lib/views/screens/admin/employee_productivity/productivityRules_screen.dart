import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view-models/admin/employee_productivity/rules_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_dialogbox.dart';
import '../../../widgets/custom_textfield.dart';

class ProductivityRulesScreen extends StatefulWidget {
  const ProductivityRulesScreen({super.key});

  @override
  State<ProductivityRulesScreen> createState() =>
      _ProductivityRulesScreenState();
}

class _ProductivityRulesScreenState extends State<ProductivityRulesScreen> {
  RulesViewModel? _rulesViewModel;

  @override
  void initState() {
    _rulesViewModel = Provider.of<RulesViewModel>(context, listen: false);
    _rulesViewModel?.getRules(context);
    super.initState();
  }

  Future<void> _refreshRules(BuildContext context) async {
    _rulesViewModel!.getRules(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Productivity Rules'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRules(context),
        child: Provider.of<RulesViewModel>(context, listen: true).loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: _rulesViewModel!.rules.isEmpty
                    ? const Center(
                        child: Text('No Rule'),
                      )
                    : ListView.builder(
                        itemCount: _rulesViewModel!.rules.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                            ),
                            child: ListTile(
                              title: Text(_rulesViewModel!.rules[index]['name'],
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                              trailing: IconButton(
                                splashRadius: 20,
                                onPressed: () {
                                  _rulesViewModel!.delete(context, index);
                                },
                                icon: const Icon(Icons.delete,
                                    color: Color(0xFF49454F)),
                              ),
                            ),
                          );
                        },
                      ),
              ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Center(
          child: GestureDetector(
            onTap: () {
              customDialogBox(
                context,
                Column(children: [
                  const Row(
                    children: [
                      Text('Add Rule',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _rulesViewModel!.ruleController,
                    hintText: 'Rule',
                    action: TextInputAction.done,
                    textInputType: TextInputType.text,
                    isFocus: true,
                  ),
                  const SizedBox(height: 25),
                ]),
                () => _rulesViewModel!.navigate(context),
                () {
                  _rulesViewModel!.addRule(context);
                  // .then((_) {
                  //   _refreshRules(context);
                  // });
                },
                'Add',
              );
            },
            child: customButton(context, 'Add Rule', 50, 211),
          ),
        ),
      ),
    );
  }
}
