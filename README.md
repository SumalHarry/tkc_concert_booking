# Concert Booking — Mini App (`miniapp_concert`)

Flutter mini-app package for concert browsing and ticket booking. This is **not
a standalone app** (no `main.dart`) — it is consumed by
[`tkc_vender_auth`](https://github.com/SumalHarry/tkc_vender_auth) as a local path dependency
and launched from the host's mini-app launcher.

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

There is nothing to run directly. Use the host app
[`tkc_vender_auth`](https://github.com/SumalHarry/tkc_vender_auth) for login, session restore,
token refresh, and authenticated API calls, then open **Concert** from the home launcher.

### Repository layout

The host expects mini apps as **sibling directories** (see `path` dependencies in the host
`pubspec.yaml`):

```
workspace/
  tkc_vender_auth/
  tkc_shopping/
  tkc_concert_booking/
```

### 1. Set up this mini app

Complete [Setup](#setup) in this repo first (`fvm use stable`, `pub get`, `make gen`).

```bash
cd tkc_concert_booking
fvm use stable
fvm flutter pub get
make gen
```

### 2. Set up and run the host

Clone the host and the other mini app as siblings, then configure and run the host:

```bash
git clone https://github.com/SumalHarry/tkc_vender_auth.git
# clone tkc_shopping next to tkc_vender_auth if you have not already

cd tkc_vender_auth
cp .env.example .env          # set BASE_URL (default http://localhost:3000)
fvm use stable
fvm flutter pub get
make gen
cd ios && pod install && cd .. # iOS only

fvm flutter run
```

### 3. Log in and open Concert

Log in on the host app, then tap **Concert** on the home screen. The host overrides this
package's Dio provider with an authenticated instance (Bearer token + automatic refresh).

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

## Screensho
<img width="400" alt="Simulator Screenshot - iPhone Air - 2026-05-17 at 14 52 13" src="https://github.com/user-attachments/assets/274a1bbf-3454-4754-9717-327508cd7a4c" />
<img width="400" alt="Simulator Screenshot - iPhone Air - 2026-05-17 at 14 52 15" src="https://github.com/user-attachments/assets/2788817c-f29e-447e-90fa-dce2d86cefcc" />
<img width="400" alt="Simulator Screenshot - iPhone Air - 2026-05-17 at 14 52 19" src="https://github.com/user-attachments/assets/673e38ea-3125-480f-911d-c90b09f97fd0" />

