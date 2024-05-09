import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:industrial_watch/constants/api_constants.dart';
import 'package:industrial_watch/utils/shared_prefs/shared_prefs.dart';
import 'package:industrial_watch/views/widgets/toast.dart';
import 'package:light_toast/light_toast.dart';
import 'package:provider/provider.dart';
import 'custom_dialogbox.dart';
import 'custom_snackbar.dart';
import 'custom_textfield.dart';

showIPDialog() async {
  // String deviceIp = await getIp();
  // String savedIp = await DataSharedPrefrences.getIp();
  // if (deviceIp == savedIp) {
  //   customSnackBar(context, deviceIp);
  //   return;
  // } else {
  //   DataSharedPrefrences.setIp(deviceIp);

  TextEditingController ipController = TextEditingController();
  return _customDialogBox(
    Column(children: [
      Row(
        children: [
          Text('Current IP Address\n${ipUrl.split('//')[1].split(':').first}',
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
        hintText: 'New IP',
        action: TextInputAction.done,
        textInputType: TextInputType.number,
        isFocus: true,
      ),
      const SizedBox(height: 25),
    ]),
    () => Get.back(),
    () {
      if (ipController.text.isNotEmpty) {
        ipUrl = 'http://${ipController.text}:5000';
        Get.back();
        Toast.show(
          'IP changed Successfully',
          showLeading: true,
          borderRadius: 30,
          icon: CupertinoIcons.info_circle,
        );
      }
    },
    'Change',
  );
  // }
}

Future getIp() async {
  String ip = '';
  var interface = await NetworkInterface.list();
  // for (var interface in await NetworkInterface.list()) {
  // print('== Interface: ${interface.name} ==');
  // for (var addr in interface.) {
  print('${interface[0].addresses[0].address}');
  ip = interface[0].addresses[0].address;
  // }
  // }
  return ip;
}

Future _customDialogBox(Widget contents, void Function() secondaryBtn,
    void Function() primaryBtn, String primaryText) {
  return Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 25, 16, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            contents,
            primaryText.isEmpty
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => secondaryBtn(),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 5),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () => primaryBtn(),
                        child: Text(primaryText),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    ),
  );
}
