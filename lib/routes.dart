import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/booking/presentation/my_bookings/screens/my_bookings_screen.dart';
import 'features/concert/presentation/concert_detail/screens/concert_detail_screen.dart';
import 'features/concert/presentation/concert_list/screens/concert_list_screen.dart';
import 'routing/route_names.dart';

/// Routes meant to be composed into the Core App `GoRouter` under `/concert`.
List<RouteBase> get concertRoutes => <RouteBase>[
      GoRoute(
        path: '/concert',
        name: ConcertRouteNames.list,
        builder: (BuildContext context, GoRouterState state) {
          return const ConcertListScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'bookings',
            name: ConcertRouteNames.bookings,
            builder: (BuildContext context, GoRouterState state) {
              return const MyBookingsScreen();
            },
          ),
          GoRoute(
            path: ':concertId',
            name: ConcertRouteNames.detail,
            builder: (BuildContext context, GoRouterState state) {
              final raw = state.pathParameters['concertId'];
              final id = raw == null ? null : int.tryParse(raw);
              if (id == null) {
                return const Scaffold(
                  body: Center(child: Text('Invalid concert link.')),
                );
              }
              return ConcertDetailScreen(concertId: id);
            },
          ),
        ],
      ),
    ];
