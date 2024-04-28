import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/section/archive_viewmodel.dart';
import 'package:industrial_watch/views/screens/admin/section/sectionDetails_screen.dart';
import 'package:provider/provider.dart';


class ArchivesScreen extends StatefulWidget {
  const ArchivesScreen({super.key});

  @override
  State<ArchivesScreen> createState() => _ArchivesScreenState();
}

class _ArchivesScreenState extends State<ArchivesScreen> {
  ArchivesViewModel? _archivesViewModel;

  @override
  void initState() {
    _archivesViewModel = Provider.of<ArchivesViewModel>(context, listen: false);
    _archivesViewModel!.getSections(context);
    super.initState();
  }

  Future<void> _refresh(BuildContext context) async {
    _archivesViewModel!.getSections(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Archives'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Provider.of<ArchivesViewModel>(context, listen: true).loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Provider.of<ArchivesViewModel>(context, listen: true)
                        .sections
                        .isEmpty
                    ? const Center(
                        child: Text('No section'),
                      )
                    : ListView.builder(
                        itemCount: _archivesViewModel!.sections.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                            ),
                            child: ListTile(
                              title: Text(
                                  _archivesViewModel!.sections[index]['name'],
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      _archivesViewModel!.archive(
                                          context,
                                          _archivesViewModel!.sections[index]
                                              ['id']);
                                    },
                                    icon: const Icon(Icons.unarchive,
                                        color: Color(0xFF49454F)),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SectionDetailsScreen(
                                      section:
                                          _archivesViewModel!.sections[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
