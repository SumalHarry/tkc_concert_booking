import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../theme/concert_theme.dart';
import '../providers/my_bookings_notifier.dart';
import '../providers/my_bookings_state.dart';
import '../widgets/booking_card.dart';
import '../widgets/cancel_dialog.dart';

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
          final cancelBusy = list.cancelBusyId == b.id;
          return BookingCard(
            booking: b,
            cancelBusy: cancelBusy,
            onCancel: cancelBusy
                ? () {}
                : () async {
                    final ok = await showCancelBookingDialog(context);
                    if (!ok || !context.mounted) return;
                    final messenger = ScaffoldMessenger.of(context);
                    final msg = await ref
                        .read(myBookingsProvider.notifier)
                        .cancel(b);
                    if (!context.mounted) return;
                    if (msg != null) {
                      messenger.showSnackBar(SnackBar(content: Text(msg)));
                    }
                  },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 120,
        leading: TextButton.icon(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.chevron_left, size: 24),
          label: Text(
            'Concerts',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: ConcertTheme.accentDeep,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Text(
          'My Bookings',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(onRefresh: onRefresh, child: body),
    );
  }
}
