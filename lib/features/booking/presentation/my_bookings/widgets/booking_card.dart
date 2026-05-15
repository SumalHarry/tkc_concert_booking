import 'package:flutter/material.dart';

import '../../../../../core/utils/date_formatters.dart';
import '../../../../../core/utils/money_formatters.dart';
import '../../../../../theme/concert_theme.dart';
import '../../../domain/entities/booking.dart';

class BookingThumb extends StatelessWidget {
  const BookingThumb({super.key, required this.bookingId});

  final int bookingId;

  @override
  Widget build(BuildContext context) {
    final gradient =
        bookingId.isEven ? ConcertTheme.heroBlue : ConcertTheme.heroPurple;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(gradient: gradient),
        alignment: Alignment.center,
        child: Icon(
          bookingId.isEven ? Icons.mic : Icons.music_note_rounded,
          color: Colors.white70,
          size: 26,
        ),
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
    this.cancelBusy = false,
  });

  final Booking booking;
  final VoidCallback onCancel;
  final bool cancelBusy;

  String get _statusLabel {
    final s = booking.status.toLowerCase();
    if (s.isEmpty) return 'Unknown';
    return s[0].toUpperCase() + s.substring(1);
  }

  bool get _isConfirmed => booking.status.toLowerCase() == 'confirmed';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: const Color(0xFF6B7280),
    );

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingThumb(bookingId: booking.id),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.concert.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(booking.concert.artist, style: muted),
                      const SizedBox(height: 6),
                      Text(
                        formatConcertDateTime(booking.concert.dateTime),
                        style: muted,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.confirmation_number_outlined,
                    size: 18, color: muted?.color),
                const SizedBox(width: 6),
                Text('${booking.quantity} tickets', style: muted),
                const Spacer(),
                Text(
                  formatBaht(booking.total),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: ConcertTheme.accentDeep,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _isConfirmed
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _statusLabel,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: _isConfirmed
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFF6B7280),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                if (cancelBusy)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else
                  TextButton(
                    onPressed: onCancel,
                    child: Text(
                      'Cancel',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
