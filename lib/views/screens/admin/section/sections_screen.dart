import 'package:flutter/material.dart';
import 'package:industrial_watch/views/screens/admin/section/sectionDetails_screen.dart';
import 'package:provider/provider.dart';

import '../../../../view-models/admin/section/sections_viewmodel.dart';
import '../../../widgets/custom_Button.dart';

class SectionsScreen extends StatefulWidget {
  const SectionsScreen({super.key});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  SectionsViewModel? _sectionsViewModel;

  @override
  void initState() {
    _sectionsViewModel = Provider.of<SectionsViewModel>(context, listen: false);
    _sectionsViewModel!.getSections(context);
    super.initState();
  }

  Future<void> _refresh(BuildContext context) async {
    _sectionsViewModel!.getSections(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Sections'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Provider.of<SectionsViewModel>(context, listen: true).loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: _sectionsViewModel!.sections.isEmpty
                    ? const Center(
                        child: Text('No section'),
                      )
                    : ListView.builder(
                        itemCount: _sectionsViewModel!.sections.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                            ),
                            child: ListTile(
                              title: Text(
                                  _sectionsViewModel!.sections[index]['name'],
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
                                      _sectionsViewModel!.edit(context, index);
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Color(0xFF49454F)),
                                  ),
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      _sectionsViewModel!
                                          .delete(context, index);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Color(0xFF49454F)),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SectionDetailsScreen(
                                          section: _sectionsViewModel!
                                              .sections[index],
                                        ),
                                      ),
                                    )
                                    .then((value) => setState(() {}));
                              },
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
              Navigator.of(context)
                  .pushNamed('/addSection')
                  .whenComplete(() => _refresh);
            },
            child: customButton(context, 'Add Section', 50, 211),
          ),
        ),
      ),
    );
  }
}
