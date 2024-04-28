import 'dart:io';

import 'package:flutter/material.dart';
import 'package:industrial_watch/contants/api_constants.dart';
import 'package:industrial_watch/utils/shared_prefs/shared_prefs.dart';

import 'custom_dialogbox.dart';
import 'custom_textfield.dart';

showIPDialog(BuildContext context) async {
  String deviceIp = await getIp();
  String savedIp = await DataSharedPrefrences.getIp();
  if (deviceIp == savedIp) {
    return;
  } else {
    DataSharedPrefrences.setIp(deviceIp);
    TextEditingController ipController = TextEditingController();
    return customDialogBox(
      context,
      Column(children: [
        Row(
          children: [
            Text(
                'Device\'s current  IP Address\n${ipUrl.split('//')[1].split(':').first}',
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: ipController,
          hintText: 'IP Address',
          action: TextInputAction.done,
          textInputType: TextInputType.number,
          isFocus: true,
        ),
        const SizedBox(height: 25),
      ]),
      () => Navigator.pop(context),
      () {
        ipUrl = 'http://${ipController.text}:5000';
        Navigator.pop(context);
      },
      'Change',
    );
  }
}

Future getIp() async {
  String ip = '';
  var interface = await NetworkInterface.list();
  // for (var interface in await NetworkInterface.list()) {
  // print('== Interface: ${interface.name} ==');
  // for (var addr in interface.addresses) {
  print('${interface[0].addresses[0].address}');
  ip = interface[0].addresses[0].address;
  // }
  // }
  return ip;
}
