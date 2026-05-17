# Concert Booking — Mini App (`miniapp_concert`)

Flutter mini-app package for concert browsing and ticket booking. This is **not
a standalone app** (no `main.dart`) — it is consumed by `tkc_core_app` as a
local path dependency and launched from the host's mini-app launcher.

## Prerequisites

- [FVM](https://fvm.app/) — all Flutter commands run via `fvm flutter`.
- A backend API (provided by the host environment).

## Setup

### 1. Install FVM

FVM (Flutter Version Management) pins the Flutter SDK used by this project.

```bash
# macOS / Linux — via Homebrew
brew tap leoafarias/fvm
brew install fvm

# or, on any platform — via Dart
dart pub global activate fvm
```

See [fvm.app/docs/getting_started/installation](https://fvm.app/docs/getting_started/installation)
for other options. Verify with `fvm --version`.

### 2. Install the Flutter SDK and dependencies

```bash
cd tkc_concert_booking

fvm use stable        # install & pin the Flutter "stable" channel
fvm flutter pub get   # get dependencies
make gen              # code generation (freezed, riverpod, json_serializable)
```

## Run

There is nothing to run directly. Launch the host app and open the concert
mini app from its launcher:

```bash
cd ../tkc_core_app
fvm flutter run
```

The host injects the auth token into this package's Dio instance.

## Common commands

```bash
make gen        # one-off code generation
make autogen    # code generation in watch mode
fvm flutter test
```

## Deploy

1. Run code generation:

```bash
make gen
```

2. Commit your changes, then push a version tag (bump to the next version):

```bash
git tag v1.0.1   # increment from the current version
git push origin v1.0.1
```

The tag version should follow [semver](https://semver.org/) and match `version` in `pubspec.yaml`.

## Architecture

Clean Architecture with feature-based folders under `lib/features/` (`concert`,
`booking`). Package entry point is `lib/miniapp_concert.dart`; the root widget
is `lib/concert_app.dart`; routes are in `lib/routes.dart`.

Never edit generated files (`.g.dart`, `.freezed.dart`) — regenerate with
`make gen`. See `CLAUDE.md` for detailed architecture notes.
