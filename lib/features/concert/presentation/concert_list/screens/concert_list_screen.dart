import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../routing/route_names.dart';
import '../../../../../theme/concert_theme.dart';
import '../widgets/concert_card.dart';
import '../providers/concert_list_notifier.dart';
import '../providers/concert_list_state.dart';

class ConcertListScreen extends HookConsumerWidget {
  const ConcertListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(concertListProvider);

    useEffect(() {
      Future.microtask(() {
        ref.read(concertListProvider.notifier).load();
      });
      return null;
    }, []);

    Future<void> onRefresh() async {
      await ref.read(concertListProvider.notifier).load();
    }

    late final Widget body;

    if (list.state == ConcertListConcreteState.failure) {
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 64),
          Text(
            list.message.isEmpty ? 'Something went wrong.' : list.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(concertListProvider.notifier).load();
              },
              child: const Text('Retry'),
            ),
          ),
        ],
      );
    } else if ((list.state == ConcertListConcreteState.initial ||
            list.state == ConcertListConcreteState.loading) &&
        list.concerts.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (!list.hasData) {
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: const [
          SizedBox(height: 48),
          Center(
            child: Text(
              'No concerts available yet.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.concerts.length,
        itemBuilder: (context, idx) {
          final c = list.concerts[idx];
          return ConcertCard(
            concert: c,
            onTap: () {
              context.pushNamed(
                ConcertRouteNames.detail,
                pathParameters: {'concertId': '${c.id}'},
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Concerts',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        leadingWidth: 96,
        leading: TextButton.icon(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.chevron_left, size: 24),
          label: Text('Home', style: Theme.of(context).textTheme.labelLarge),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pushNamed(ConcertRouteNames.bookings);
            },
            child: Text(
              'My Bookings',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: ConcertTheme.accentDeep,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: RefreshIndicator(onRefresh: onRefresh, child: body),
    );
  }
}
