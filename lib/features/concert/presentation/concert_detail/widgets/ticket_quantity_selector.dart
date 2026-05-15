import 'package:flutter/material.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        _CircleStepButton(
          icon: Icons.remove,
          enabled: canDecrease,
          onTap: onMinus,
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        _CircleStepButton(
          icon: Icons.add,
          enabled: canIncrease,
          onTap: onPlus,
        ),
      ],
    );
  }
}

class _CircleStepButton extends StatelessWidget {
  const _CircleStepButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final color = enabled ? const Color(0xFF6B7280) : const Color(0xFFD1D5DB);
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.5),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
