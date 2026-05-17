import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:miniapp_concert/routing/route_names.dart';

import '../../../../../shared/widgets/concert_app_bar.dart';
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

    final textTheme = Theme.of(context).textTheme;

    if (list.state == ConcertListConcreteState.failure) {
      body = ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 64),
          Text(
            list.message.isEmpty ? 'Something went wrong.' : list.message,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(concertListProvider.notifier).load();
              },
              child: Text('Retry', style: textTheme.labelLarge),
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
        children: [
          const SizedBox(height: 48),
          Center(
            child: Text(
              'No concerts available yet.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      );
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.concerts.length,
        itemBuilder: (context, index) {
          final concert = list.concerts[index];
          return ConcertCard(
            concert: concert,
            onTap: () {
              context.pushNamed(
                ConcertRouteNames.detail,
                pathParameters: {'concertId': '${concert.id}'},
              );
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: const ConcertAppBar(
        title: 'Concerts',
        backLabel: 'Home',
        showActions: true,
      ),
      body: RefreshIndicator(onRefresh: onRefresh, child: body),
    );
  }
}
