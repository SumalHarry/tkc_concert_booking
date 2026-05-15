import 'package:intl/intl.dart';

final _thb =
    NumberFormat.currency(locale: 'th_TH', symbol: '฿', decimalDigits: 0);

String formatBaht(num amount) {
  return _thb.format(amount);
}
