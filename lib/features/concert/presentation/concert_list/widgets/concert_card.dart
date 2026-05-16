import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/date_formatters.dart';
import '../../../../../core/utils/money_formatters.dart';
import '../../../../../theme/concert_theme.dart';
import '../../../domain/entities/concert.dart';

class ConcertHero extends StatelessWidget {
  const ConcertHero({
    super.key,
    required this.concert,
    this.height = 160,
    this.borderRadius = const BorderRadius.vertical(top: Radius.circular(14)),
  });

  final Concert concert;
  final double height;
  final BorderRadius borderRadius;

  LinearGradient get _gradient =>
      concert.id.isEven ? ConcertTheme.heroBlue : ConcertTheme.heroPurple;

  @override
  Widget build(BuildContext context) {
    final url = concert.imageUrl;
    Widget child;

    final hasRemote = Uri.tryParse(url)?.hasAbsolutePath == true &&
        (url.startsWith('http'));

    if (hasRemote) {
      child = CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        memCacheHeight: (height * 2).toInt(),
        placeholder: (context, url) => Center(child: _placeholderContents()),
        errorWidget: (context, url, error) => Container(
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: _gradient,
            borderRadius: borderRadius,
          ),
          child: _placeholderContents(),
        ),
      );
    } else {
      child = Container(
        height: height,
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: _placeholderContents(),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: child,
    );
  }

  Widget _placeholderContents() {
    return Icon(
      concert.id.isEven ? Icons.mic : Icons.music_note_rounded,
      size: 48,
      color: Colors.white70,
    );
  }
}

class ConcertCard extends StatelessWidget {
  const ConcertCard({
    super.key,
    required this.concert,
    required this.onTap,
  });

  final Concert concert;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final subtitleStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: const Color(0xFF6B7280),
        );

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConcertHero(concert: concert, height: 160),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    concert.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(concert.artist, style: subtitleStyle),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month,
                          size: 18, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          formatConcertDateTime(concert.dateTime),
                          style: subtitleStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          concert.location,
                          style: subtitleStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: const BoxDecoration(
                color: ConcertTheme.cardFooter,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
              ),
              child: Row(
                children: [
                  Text(
                    formatBaht(concert.pricePerTicket),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ConcertTheme.accent,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    '${concert.availableSeats} seats left',
                    style: subtitleStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
