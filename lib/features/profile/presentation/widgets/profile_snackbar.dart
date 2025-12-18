import 'package:flutter/material.dart';

class ProfileSnackBar {
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    VoidCallback? onDiscard,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: onDiscard != null
            ? SnackBarAction(
                label: 'Descartar',
                textColor: Colors.white,
                onPressed: onDiscard,
              )
            : null,
      ),
    );
  }
}
