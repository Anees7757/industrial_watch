import 'package:flutter/material.dart';

Future customDialogBox(
    BuildContext context,
    Widget contents,
    void Function() secondaryBtn,
    void Function() primaryBtn,
    String primaryText) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              contents,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => secondaryBtn(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
