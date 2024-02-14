import 'package:flutter/material.dart';

void showErrorScreen(BuildContext context, int statusCode, String message) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    builder: (BuildContext context) {
      return CustomError(statusCode: statusCode, message: message);
    },
  ));
}

class CustomError extends StatelessWidget {
  final int statusCode;
  final String message;

  const CustomError({
    Key? key,
    required this.statusCode,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath = _getImagePath(statusCode);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 300,
              width: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        label: const Text('Close'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  String _getImagePath(int statusCode) {
    switch (statusCode) {
      case 404:
        return 'assets/images/404.jpg';
      case 500:
        return 'assets/images/500.jpg';
      case 503:
        return 'assets/images/503.jpg';
      case 504:
        return 'assets/images/404.jpg';
      default:
        return 'assets/images/default_error.jpg';
    }
  }
}
