import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final Future<void> Function() onRetry;
  final ThemeData theme;
  final String? errorMessage;

  const ErrorMessage(
      {super.key,
      required this.onRetry,
      required this.theme,
      this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 128,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              errorMessage ?? "Something went wrong",
              style: const TextStyle(fontSize: 24),
            ),
          ),
          TextButton(
              onPressed: onRetry,
              child: const Text("Retry",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
