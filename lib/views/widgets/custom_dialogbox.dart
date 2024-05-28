import 'package:flutter/material.dart';

Future customDialogBox(
    BuildContext context,
    Widget contents,
    void Function() secondaryBtn,
    void Function() primaryBtn,
    String primaryText) {
  return showDialog(
    context: context,
    barrierDismissible: primaryText.isEmpty ? false : true,
    builder: (context) {
      return Dialog(
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
      );
    },
  );
}
