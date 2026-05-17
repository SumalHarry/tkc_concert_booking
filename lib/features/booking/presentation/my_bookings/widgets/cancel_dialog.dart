import 'package:flutter/material.dart';

Future<void> showCancelBookingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      return AlertDialog(
        title: Text('Cancel Booking', style: theme.textTheme.titleLarge),
        content: Text(
          'Are you sure you want to cancel this booking?',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('No', style: theme.textTheme.labelLarge),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Yes, Cancel',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      );
    },
  );
}
