import 'package:flutter/material.dart';

typedef DoubleCallback = double Function();

extension ExtensionOnContext on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  double get statusBarSize => MediaQuery.of(this).viewPadding.top;

  void showMessage(String message, SnackBarType type) {
    final isError = type == SnackBarType.error;
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error : Icons.check_circle,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(message,
              style: textTheme.labelMedium!.copyWith(color: Colors.white)),
        ],
      ),
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
      backgroundColor: isError ? Colors.red[400] : Colors.green[400],
    ));
  }
}

enum SnackBarType { error, success }
