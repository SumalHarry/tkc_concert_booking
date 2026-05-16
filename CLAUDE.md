# tkc_concert_booking

Flutter mini app package for concert browsing and ticket booking. Consumed by `tkc_core_app` as a local path dependency (`miniapp_concert`).

## Tech Stack

- **Flutter** package (not a standalone app — no `main.dart`)
- **State management**: Riverpod (`riverpod_annotation`)
- **Networking**: `dio`
- **Data modeling**: `freezed` + `json_serializable`

## Commands

```bash
# Code generation (freezed, riverpod, json_serializable)
make gen

# Watch mode for code gen
make autogen

# Get dependencies
fvm flutter pub get
```

## Architecture

Clean Architecture with feature-based folder structure:

```
lib/
  miniapp_concert.dart   # package entry point (exports)
  concert_app.dart       # root widget for the mini app
  routes.dart            # GoRouter routes for this mini app
  routing/
    route_names.dart
  theme/
    concert_theme.dart
  core/
    network/
      concert_dio_provider.dart   # Dio instance for this mini app
      dio_mapper.dart
      as_object_list.dart
      models/                     # Either, AppException, Unit
    error/
      failure.dart
    utils/
      money_formatters.dart
      date_formatters.dart
  shared/
    widgets/
      concert_app_bar.dart
  features/
    concert/             # browse concerts
    booking/             # book tickets, view my bookings
```

Each feature follows:
```
feature/
  data/
    datasources/     # remote Dio calls
    repositories/    # repository implementations
  domain/
    entities/        # Freezed models
    repositories/    # abstract interfaces
    providers/       # Riverpod providers
  presentation/
    <screen_name>/
      providers/     # notifier + state
      screens/
      widgets/
```

## Features

### Concert
- `concert_list` — browsable list of concerts with `ConcertCard`
- `concert_detail` — details + ticket quantity selector, triggers booking

### Booking
- `booking` — creates a booking via API
- `my_bookings` — lists user's bookings with cancel dialog

## Key Patterns

- **Entry point**: Host app embeds this via `ConcertApp` widget and delegates routing to `routes.dart`
- **Dio**: `concertDioProvider` supplies a pre-configured Dio instance (auth token injected by host)
- **Either**: `Either<Failure, T>` for data/domain error propagation
- **Models**: `@freezed` + `@JsonSerializable`; generated files end in `.freezed.dart` / `.g.dart` — never edit them

## Generated Files

Never manually edit files ending in `.g.dart` or `.freezed.dart`. Regenerate with `make gen`.
