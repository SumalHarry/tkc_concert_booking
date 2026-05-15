import 'package:flutter/material.dart';

Future<void> showCancelBookingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Cancel Booking'),
      content: const Text('Are you sure you want to cancel this booking?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text(
            'Yes, Cancel',
            style: TextStyle(color: Theme.of(ctx).colorScheme.error),
          ),
        ),
      ],
    ),
  );
}
