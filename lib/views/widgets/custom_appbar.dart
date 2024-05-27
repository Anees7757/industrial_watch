import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../view-models/admin/production/addProduct_viewmodel.dart';

AppBar customAppBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleSpacing: 12,
    centerTitle: false,
    leadingWidth: 15,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const SizedBox(width: 7),
        Text(title, style: const TextStyle(color: Colors.black)),
      ],
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    actions: title == ''
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
                    AddProductViewModel addProductViewModel =
                        Provider.of<AddProductViewModel>(context,
                            listen: false);

                    addProductViewModel.showDialog(context);
                  },
                  child: const Text('Add Material'),
                ),
              ),
            ),
          ]
        : [],
  );
}
