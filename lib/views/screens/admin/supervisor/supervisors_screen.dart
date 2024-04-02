import 'package:flutter/material.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';
import 'package:provider/provider.dart';

import '../../../../view-models/admin/supervisor/supervisorsView_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_dialogbox.dart';
import '../../../widgets/custom_textfield.dart';

class SupervisorScreen extends StatefulWidget {
  const SupervisorScreen({super.key});

  @override
  State<SupervisorScreen> createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  SupervisorsViewModel? _supervisorViewModel;

  @override
  void initState() {
    _supervisorViewModel =
        Provider.of<SupervisorsViewModel>(context, listen: false);
    _supervisorViewModel!.getSupervisors(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Supervisors'),
      ),
      body: Provider.of<SupervisorsViewModel>(context, listen: true).loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: _supervisorViewModel!.supervisors.isEmpty
                  ? const Center(
                      child: Text('No Supervisor'),
                    )
                  : ListView.builder(
                      itemCount: _supervisorViewModel!.supervisors.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFDDDDDD).withOpacity(0.5),
                          ),
                          child: ListTile(
                            title: Text(
                                _supervisorViewModel!.supervisors
                                    .elementAt(index)['name'],
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                )),
                            subtitle: Text(
                                _supervisorViewModel!.supervisors
                                    .elementAt(index)['username'],
                                overflow: TextOverflow.visible,
                                style: const TextStyle()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    customDialogBox(
                                        context,
                                        Column(
                                          children: [
                                            const Text('New Credentials for',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                )),
                                            Text(
                                                _supervisorViewModel!
                                                    .supervisors
                                                    .elementAt(
                                                        index)['username'],
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            const SizedBox(height: 25),
                                            CustomTextField(
                                              controller: _supervisorViewModel!
                                                  .usernameController,
                                              hintText: 'Username',
                                              action: TextInputAction.next,
                                              textInputType: TextInputType.text,
                                              isFocus: true,
                                            ),
                                            const SizedBox(height: 10),
                                            CustomTextField(
                                              controller: _supervisorViewModel!
                                                  .passwordController,
                                              hintText: 'Password ',
                                              action: TextInputAction.done,
                                              textInputType: TextInputType.text,
                                              isFocus: false,
                                            ),
                                            const SizedBox(height: 25),
                                          ],
                                        ),
                                        () => _supervisorViewModel!
                                            .dialogCancel(context), () {
                                      _supervisorViewModel!
                                          .edit(context, index);
                                      setState(() {});
                                    }, 'Update');
                                  },
                                  icon: const Icon(Icons.edit,
                                      color: Color(0xFF49454F)),
                                ),
                                IconButton(
                                  splashRadius: 20,
                                  onPressed: () {
                                    _supervisorViewModel!
                                        .delete(context, index);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Color(0xFF49454F)),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => SectionDetailsScreen(
                              //       section: _sectionsViewModel!.sections[index],
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                        );
                      },
                    ),
            ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/addSupervisor')
                  .whenComplete(() => setState(() {}));
            },
            child: customButton(
                context, 'Add Supervisor', 56.79, double.infinity), // 211
          ),
        ),
      ),
    );
  }
}
