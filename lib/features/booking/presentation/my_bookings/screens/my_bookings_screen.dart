import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../shared/widgets/concert_app_bar.dart';
import '../providers/my_bookings_notifier.dart';
import '../providers/my_bookings_state.dart';
import '../widgets/booking_card.dart';

class MyBookingsScreen extends HookConsumerWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(myBookingsProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(myBookingsProvider.notifier).load();
      });
      return null;
    }, []);

    Future<void> onRefresh() async {
      await ref.read(myBookingsProvider.notifier).load();
    }

    late final Widget body;

    if (list.state == MyBookingsConcreteState.failure) {
      final textTheme = Theme.of(context).textTheme;
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 64),
          Text(
            list.message.isEmpty ? 'Could not load bookings.' : list.message,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(myBookingsProvider.notifier).load();
              },
              child: Text('Retry', style: textTheme.labelLarge),
            ),
          ),
        ],
      );
    } else if ((list.state == MyBookingsConcreteState.initial ||
            list.state == MyBookingsConcreteState.loading) &&
        list.bookings.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (!list.hasData) {
      final textTheme = Theme.of(context).textTheme;
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 56),
          const Icon(
            Icons.event_available_outlined,
            size: 44,
            color: Color(0xFF9CA3AF),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              'No bookings yet.\nPick a concert and tap Book Now.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      );
    } else {
      // Group bookings by concertId and sum quantities
      final grouped = <int, ({int concertId, int totalQuantity, int totalPrice, int firstBookingId})>{};
      for (final booking in list.bookings) {
        final existing = grouped[booking.concertId];
        if (existing == null) {
          grouped[booking.concertId] = (
            concertId: booking.concertId,
            totalQuantity: booking.quantity,
            totalPrice: booking.totalPrice,
            firstBookingId: booking.id,
          );
        } else {
          grouped[booking.concertId] = (
            concertId: booking.concertId,
            totalQuantity: existing.totalQuantity + booking.quantity,
            totalPrice: existing.totalPrice + booking.totalPrice,
            firstBookingId: existing.firstBookingId,
          );
        }
      }
      final groupedList = grouped.values.toList();

      body = ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: groupedList.length,
        itemBuilder: (context, index) {
          final groupedBooking = groupedList[index];
          return BookingCard(
            concertId: groupedBooking.concertId,
            totalQuantity: groupedBooking.totalQuantity,
            totalPrice: groupedBooking.totalPrice,
            bookingId: groupedBooking.firstBookingId,
            concert: list.concertFor(groupedBooking.concertId),
          );
        },
      );
    }

    return Scaffold(
      appBar: const ConcertAppBar(
        title: 'My Bookings',
        backLabel: 'Concerts',
      ),
      body: RefreshIndicator(onRefresh: onRefresh, child: body),
    );
  }
}
