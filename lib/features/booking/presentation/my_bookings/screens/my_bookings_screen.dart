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
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 64),
          Text(
            list.message.isEmpty ? 'Could not load bookings.' : list.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(myBookingsProvider.notifier).load();
              },
              child: const Text('Retry'),
            ),
          ),
        ],
      );
    } else if ((list.state == MyBookingsConcreteState.initial ||
            list.state == MyBookingsConcreteState.loading) &&
        list.bookings.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (!list.hasData) {
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 56),
          Icon(
            Icons.event_available_outlined,
            size: 44,
            color: Color(0xFF9CA3AF),
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              'No bookings yet.\nPick a concert and tap Book Now.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.bookings.length,
        itemBuilder: (context, idx) {
          final b = list.bookings[idx];
          return BookingCard(
            booking: b,
            concert: list.concertFor(b.concertId),
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
