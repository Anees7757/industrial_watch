import 'package:flutter/material.dart';

Future logoutDialogBox(BuildContext context, void Function() primaryBtn) {
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
              const Text('Do you really want to logout?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  )),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
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
                    child: const Text('Yes'),
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
