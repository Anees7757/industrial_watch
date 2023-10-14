import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../view-models/admin/production/createBatch_viewModel.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleSpacing: 0,
    centerTitle: false,
    leadingWidth: 15,
    title: Row(
      children: [
        RawMaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          constraints: const BoxConstraints(minWidth: 35, minHeight: 35),
          elevation: 2.0,
          fillColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(5.0),
          shape: const CircleBorder(),
          child: const Center(
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(title, style: const TextStyle(color: Colors.black)),
      ],
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    actions: title == 'Create Batch'
        ? [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: FilledButton(
                  onPressed: () {
                    CreateBatchViewModel createBatchViewModel =
                    Provider.of<CreateBatchViewModel>(context, listen: false);

                    createBatchViewModel.showDialog(context);
                  },
                  child: const Text('Add Material'),
                ),
              ),
            ),
          ]
        : [],
  );
}
