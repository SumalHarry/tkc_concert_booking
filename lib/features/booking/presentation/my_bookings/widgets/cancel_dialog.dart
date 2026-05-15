import 'package:flutter/material.dart';

Future<bool> showCancelBookingDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Cancel booking?'),
        content: const Text(
          'This will release your seats back to availability (if your backend supports cancellation).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Cancel booking'),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
