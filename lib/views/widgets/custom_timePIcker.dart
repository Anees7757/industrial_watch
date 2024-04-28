import 'package:flutter/material.dart';

Future<String> customTimePicker(BuildContext context, String currentVal) async {
  String formattedTime = '';
  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  if (currentVal.isNotEmpty) {
    hourController.text = currentVal.split(':')[0];
    minuteController.text = currentVal.split(':')[1];
  }

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Text(
          "Enter Allowed Time".toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding:
            EdgeInsets.only(bottom: 20, top: 20, left: 25, right: 25),
        titlePadding: EdgeInsets.only(bottom: 0, top: 20, left: 25),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          counterText: '',
                          hintText: '00',
                        ),
                        style: TextStyle(
                          fontSize: 40,
                        ),
                        controller: hourController,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    ":",
                    style: TextStyle(
                      fontSize: 37,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          counterText: '',
                          hintText: '00',
                        ),
                        style: TextStyle(
                          fontSize: 40,
                        ),
                        controller: minuteController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  child: Text(
                    "Hour",
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    "Minute",
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            onPressed: () {
              int hours = int.tryParse(hourController.text) ?? 0;
              int minutes = int.tryParse(minuteController.text) ?? 0;

              formattedTime =
                  "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";

              print(formattedTime);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  if (formattedTime.isNotEmpty) {
    return formattedTime;
  } else {
    return '';
  }
}
