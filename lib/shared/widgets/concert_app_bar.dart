import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../routing/route_names.dart';
import '../../theme/concert_theme.dart';

class ConcertAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const ConcertAppBar({
    super.key,
    required this.title,
    required this.backLabel,
    this.showActions = false,
    this.transparent = false,
  });

  final String title;
  final String backLabel;
  final bool showActions;
  final bool transparent;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foreground = transparent ? Colors.white : null;
    final accentColor = transparent ? Colors.white : ConcertTheme.accentDeep;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      backgroundColor: transparent ? Colors.transparent : null,
      foregroundColor: foreground,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chevron_left, size: 24, color: accentColor),
                  Text(
                    backLabel,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (title.isNotEmpty)
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ),
            ),
        ],
      ),
      centerTitle: false,
      actions: showActions
          ? [
              TextButton(
                onPressed: () =>
                    context.pushNamed(ConcertRouteNames.bookings),
                child: Text(
                  'My Bookings',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ConcertTheme.accentDeep,
                      ),
                ),
              ),
              const SizedBox(width: 4),
            ]
          : null,
    );
  }
}
