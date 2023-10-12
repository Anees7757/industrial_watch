import 'package:flutter/material.dart';
import 'package:industrial_watch/view/screens/admin/section/sectionDetails_screen.dart';
import 'package:industrial_watch/view/view-model/admin/section/sections_viewmodel.dart';
import 'package:provider/provider.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Sections'),
      ),
      body: Container(
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
                      title: Text(_sectionsViewModel!.sections[index],
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
                              _sectionsViewModel!.delete(context, index);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete,
                                color: Color(0xFF49454F)),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SectionDetailsScreen(
                              section: _sectionsViewModel!.sections[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
      bottomSheet: SizedBox(
        height: 100,
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/addSection')
                  .whenComplete(() => setState(() {}));
            },
            child: customButton(context, 'Add Section', 50, 211),
          ),
        ),
      ),
    );
  }
}
