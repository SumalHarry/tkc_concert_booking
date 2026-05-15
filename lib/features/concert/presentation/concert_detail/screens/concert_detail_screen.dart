import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/date_formatters.dart';
import '../../../../../core/utils/money_formatters.dart';
import '../../../../../theme/concert_theme.dart';
import '../../concert_list/widgets/concert_card.dart';
import '../widgets/ticket_quantity_selector.dart';
import '../providers/concert_detail_notifier.dart';
import '../providers/concert_detail_state.dart';

class ConcertDetailScreen extends HookConsumerWidget {
  const ConcertDetailScreen({super.key, required this.concertId});

  final int concertId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = concertDetailProvider(concertId);
    final s = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    useEffect(() {
      Future.microtask(notifier.load);
      return null;
    }, [concertId]);

    final theme = Theme.of(context);

    final concertForActions = s.concert;
    final qtyForActions = s.clampedQuantity;
    final canBook =
        concertForActions != null &&
        concertForActions.availableSeats > 0 &&
        qtyForActions > 0 &&
        !s.bookingBusy;

    Future<void> onBook() async {
      final ok = await notifier.book();
      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      if (ok) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Booking confirmed.')),
        );
        context.pop();
        return;
      }

      final msg = ref.read(provider).message;
      if (msg.isNotEmpty) {
        messenger.showSnackBar(SnackBar(content: Text(msg)));
      }
    }

    Widget content;

    if (s.state == ConcertDetailConcreteState.failure && s.concert == null) {
      content = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 64),
          Text(
            s.message.isEmpty ? 'Could not load this concert.' : s.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: notifier.load,
              child: const Text('Retry'),
            ),
          ),
        ],
      );
    } else if (s.state == ConcertDetailConcreteState.loading &&
        s.concert == null) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      final concert = s.concert;
      if (concert == null) {
        content = const SizedBox.shrink();
      } else {
        final qty = s.clampedQuantity;

        content = CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: ConcertHero(concert: concert, height: 230),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -22),
                child: Material(
                  color: Colors.white,
                  elevation: 6,
                  shadowColor: Colors.black26,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          concert.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          concert.artist,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          icon: Icons.calendar_month,
                          iconColor: ConcertTheme.accent,
                          title: 'Date & Time',
                          value: formatConcertDateTime(concert.dateTime),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          iconColor: const Color(0xFFE53935),
                          title: 'Venue',
                          value: concert.venue,
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.confirmation_number_outlined,
                          iconColor: const Color(0xFF43A047),
                          title: 'Available Seats',
                          value:
                              '${concert.availableSeats} / ${concert.totalSeats}',
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Text(
                              'Tickets',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Spacer(),
                            TicketQuantitySelector(
                              quantity: qty <= 0 ? 0 : qty,
                              canDecrease: qty > 1 && !s.bookingBusy,
                              canIncrease:
                                  qty < concert.availableSeats &&
                                  !s.bookingBusy,
                              onMinus: notifier.decrement,
                              onPlus: notifier.increment,
                            ),
                          ],
                        ),
                        if (s.state == ConcertDetailConcreteState.failure &&
                            s.message.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            s.message,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          icon: const Icon(Icons.chevron_left, size: 24),
          label: const Text('Concerts'),
        ),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: (s.concert == null)
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          formatBaht(s.totalPrice),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: ConcertTheme.accentDeep,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: canBook ? onBook : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConcertTheme.accent,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFFFFE0B2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: s.bookingBusy
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Book Now',
                                  key: ValueKey('book_label'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: RefreshIndicator(onRefresh: notifier.load, child: content),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: const Color(0xFF6B7280),
      fontWeight: FontWeight.w500,
    );
    final valueStyle = Theme.of(
      context,
    ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: muted),
              const SizedBox(height: 2),
              Text(value, style: valueStyle),
            ],
          ),
        ),
      ],
    );
  }
}
