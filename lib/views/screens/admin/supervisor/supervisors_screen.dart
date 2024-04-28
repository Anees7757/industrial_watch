import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view-models/admin/supervisor/supervisorsView_viewmodel.dart';
import 'editSupervisor_screen.dart';

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

  Future<void> _refresh(BuildContext context) async {
    _supervisorViewModel!.getSupervisors(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Supervisors'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Provider.of<SupervisorsViewModel>(context, listen: true).loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: Provider.of<SupervisorsViewModel>(context, listen: true)
                      .loading
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
                              itemCount:
                                  _supervisorViewModel!.supervisors.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xFFDDDDDD)
                                        .withOpacity(0.5),
                                  ),
                                  child: ListTile(
                                    isThreeLine: true,
                                    title: Text(
                                        _supervisorViewModel!.supervisors
                                            .elementAt(index)['employee_name'],
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        )),
                                    subtitle: Text(
                                        _supervisorViewModel!.supervisors
                                            .elementAt(index)['sections']
                                            .join(','),
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle()),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          splashRadius: 20,
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditSupervisorScreen(
                                                      supervisor:
                                                          _supervisorViewModel!
                                                                  .supervisors[
                                                              index],
                                                    ),
                                                  ),
                                                )
                                                .then(
                                                  (value) => _refresh(context),
                                                );
                                          },
                                          icon: const Icon(Icons.edit,
                                              color: Color(0xFF49454F)),
                                        ),
                                      ],
                                    ),
                                    onTap: () {},
                                  ),
                                );
                              },
                            ),
                    ),
            ),
    );
  }
}
