import 'package:flutter/material.dart';

import '../../../../../core/utils/date_formatters.dart';
import '../../../../../core/utils/money_formatters.dart';
import '../../../../../theme/concert_theme.dart';
import '../../../../concert/domain/entities/concert.dart';
import 'cancel_dialog.dart';

class _BookingThumb extends StatelessWidget {
  const _BookingThumb({required this.concert, required this.bookingId});

  final Concert? concert;
  final int bookingId;

  @override
  Widget build(BuildContext context) {
    final gradient =
        bookingId.isEven ? ConcertTheme.heroBlue : ConcertTheme.heroPurple;
    final icon =
        bookingId.isEven ? Icons.mic : Icons.music_note_rounded;

    final c = concert;
    final hasRemote = c != null &&
        c.imageUrl.startsWith('http');

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 56,
        height: 56,
        child: hasRemote
            ? Image.network(
                c.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(gradient, icon),
              )
            : _placeholder(gradient, icon),
      ),
    );
  }

  Widget _placeholder(LinearGradient gradient, IconData icon) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white70, size: 26),
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.concertId,
    required this.totalQuantity,
    required this.totalPrice,
    required this.bookingId,
    this.concert,
  });

  final int concertId;
  final int totalQuantity;
  final int totalPrice;
  final int bookingId;
  final Concert? concert;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: const Color(0xFF6B7280),
    );

    final name = concert?.name ?? 'Concert #$concertId';
    final artist = concert?.artist;
    final dateTime = concert?.dateTime;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 14),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BookingThumb(concert: concert, bookingId: bookingId),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (artist != null) ...[
                        const SizedBox(height: 3),
                        Text(artist, style: muted),
                      ],
                      if (dateTime != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          formatConcertDateTime(dateTime),
                          style: muted,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(Icons.confirmation_number_outlined,
                    size: 18, color: muted?.color),
                const SizedBox(width: 6),
                Text(
                  '$totalQuantity ${totalQuantity == 1 ? 'ticket' : 'tickets'}',
                  style: muted,
                ),
                const Spacer(),
                Text(
                  formatBaht(totalPrice),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: ConcertTheme.accentDeep,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _ConfirmedBadge(),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () => showCancelBookingDialog(context),
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

class _ConfirmedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Confirmed',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF2E7D32),
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }
}
