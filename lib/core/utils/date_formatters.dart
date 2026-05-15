import 'package:intl/intl.dart';

String formatConcertDateTime(String iso) {
  try {
    final dt = DateTime.parse(iso).toLocal();
    return DateFormat('MMM d, yyyy - HH:mm').format(dt);
  } catch (_) {
    return iso;
  }
}
