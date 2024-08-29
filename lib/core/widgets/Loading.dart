import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  // Show the dialog
  final dialog = showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Please Wait"),
        content: Container(
          color: Colors.transparent,
          height: 50,
          child: const Center(
            child: CircularProgressIndicator(
              color:
                  Colors.blue, // Replace with ColorManager.mainColor if needed
            ),
          ),
        ),
      );
    },
    barrierDismissible:
        false, // Prevents closing the dialog by tapping outside of it
  );

  // Dismiss the dialog after the specified duration
  Future.delayed(const Duration(seconds: 3), () {
    Navigator.of(context, rootNavigator: true)
        .pop(); // Use rootNavigator to ensure it's closed
  });
}
