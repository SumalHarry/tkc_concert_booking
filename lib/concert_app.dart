import 'package:flutter/material.dart';

import 'features/concert/presentation/concert_list/screens/concert_list_screen.dart';

/// Entry surface mounted by the Core App after overriding [concertDioProvider].
class ConcertApp extends StatelessWidget {
  const ConcertApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ConcertListScreen();
  }
}
