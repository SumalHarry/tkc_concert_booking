import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/date_formatters.dart';
import '../../../../../core/utils/money_formatters.dart';
import '../../../../../shared/widgets/concert_app_bar.dart';
import '../../../../../theme/concert_theme.dart';
import '../../concert_list/widgets/concert_card.dart';
import '../widgets/info_row.dart';
import '../widgets/ticket_quantity_selector.dart';
import '../../concert_list/providers/concert_list_notifier.dart';
import '../providers/concert_detail_notifier.dart';
import '../providers/concert_detail_state.dart';

class ConcertDetailScreen extends HookConsumerWidget {
  const ConcertDetailScreen({super.key, required this.concertId});

  final int concertId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = concertDetailProvider(concertId);
    final concertDetailState = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    useEffect(() {
      Future.microtask(notifier.load);
      return null;
    }, [concertId]);

    final theme = Theme.of(context);

    final concertForActions = concertDetailState.concert;
    final quantityForActions = concertDetailState.clampedQuantity;
    final canBook = concertForActions != null &&
        concertForActions.availableSeats > 0 &&
        quantityForActions > 0 &&
        !concertDetailState.bookingBusy;

    Future<void> onBook() async {
      final ok = await notifier.book();
      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      if (ok) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Booking confirmed.'),
            backgroundColor: ConcertTheme.accent,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(concertListProvider.notifier).load();
        await notifier.load();
        if (!context.mounted) return;
        context.pop();
        return;
      }

      final msg = ref.read(provider).message;
      if (msg.isNotEmpty) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    Widget content;

    if (concertDetailState.state == ConcertDetailConcreteState.failure &&
        concertDetailState.concert == null) {
      content = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 64),
          Text(
            concertDetailState.message.isEmpty
                ? 'Could not load this concert.'
                : concertDetailState.message,
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
    } else if (concertDetailState.state == ConcertDetailConcreteState.loading &&
        concertDetailState.concert == null) {
      content = const Center(child: CircularProgressIndicator());
    } else {
      final concert = concertDetailState.concert;
      if (concert == null) {
        content = const SizedBox.shrink();
      } else {
        final quantity = concertDetailState.clampedQuantity;

        content = ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120),
          children: [
            ConcertHero(
              concert: concert,
              height: 240,
              borderRadius: BorderRadius.zero,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    concert.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    concert.artist,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InfoRow(
                    icon: Icons.calendar_month,
                    iconColor: ConcertTheme.accent,
                    title: 'Date & Time',
                    value: formatConcertDateTime(concert.dateTime),
                  ),
                  const SizedBox(height: 14),
                  InfoRow(
                    icon: Icons.location_on_outlined,
                    iconColor: const Color(0xFFE53935),
                    title: 'Venue',
                    value: concert.location,
                  ),
                  const SizedBox(height: 14),
                  InfoRow(
                    icon: Icons.confirmation_number_outlined,
                    iconColor: const Color(0xFF43A047),
                    title: 'Available Seats',
                    value: '${concert.availableSeats} / ${concert.totalSeats}',
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
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
                        quantity: quantity <= 0 ? 0 : quantity,
                        canDecrease:
                            quantity > 1 && !concertDetailState.bookingBusy,
                        canIncrease: quantity < concert.availableSeats &&
                            !concertDetailState.bookingBusy,
                        onMinus: notifier.decrement,
                        onPlus: notifier.increment,
                      ),
                    ],
                  ),
                  if (concertDetailState.state ==
                          ConcertDetailConcreteState.failure &&
                      concertDetailState.message.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      concertDetailState.message,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      }
    }

    return Scaffold(
      appBar: const ConcertAppBar(
        title: '',
        backLabel: 'Concerts',
      ),
      bottomNavigationBar: (concertDetailState.concert == null)
          ? null
          : SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          formatBaht(concertDetailState.totalPrice),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: ConcertTheme.accentDeep,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: canBook ? onBook : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ConcertTheme.accent,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: const Color(0xFFFFE0B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: concertDetailState.bookingBusy
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
                    ),
                  ],
                ),
              ),
            ),
      body: RefreshIndicator(onRefresh: notifier.load, child: content),
    );
  }
}
