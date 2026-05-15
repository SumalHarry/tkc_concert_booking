import 'package:flutter/material.dart';

import '../../../../../theme/concert_theme.dart';

class TicketQuantitySelector extends StatelessWidget {
  const TicketQuantitySelector({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
    required this.canDecrease,
    required this.canIncrease,
  });

  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final bool canDecrease;
  final bool canIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _CircleButton(
          icon: Icons.remove,
          enabled: canDecrease,
          onTap: canDecrease ? onMinus : null,
          filled: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            '$quantity',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _CircleButton(
          icon: Icons.add,
          enabled: canIncrease,
          onTap: canIncrease ? onPlus : null,
          outlined: true,
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    this.onTap,
    this.enabled = true,
    this.filled = false,
    this.outlined = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;
  final bool filled;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    Color? bg = const Color(0xFFE5E7EB);
    Border? border;

    if (outlined && enabled) {
      bg = Colors.white;
      border = Border.all(color: ConcertTheme.accentDeep, width: 1);
    }

    final child = Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: filled ? bg : bg,
        border: border ?? Border.all(color: Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20,
        color: enabled ? const Color(0xFF374151) : Colors.black26,
      ),
    );

    if (!enabled) {
      return Opacity(opacity: 0.5, child: child);
    }

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
