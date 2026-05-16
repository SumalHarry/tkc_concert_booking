# Claude Code Skills — tkc_concert_booking

Useful Claude Code slash commands for working in this mini app package.

## `/init`
Regenerates or updates `CLAUDE.md` from the current codebase state.
Use after adding new features or entities to keep docs accurate.

## `/review`
Reviews the current branch's changes.
Useful before handing off to `tkc_core_app` integration — checks concert/booking layers.

## `/security-review`
Audits pending changes for security issues.
Relevant when touching booking API calls, payment data, or response parsing.

## `/simplify`
Reviews changed code for quality and removes unnecessary abstractions.
Handy after adding new endpoints to `BookingRemoteDatasource` or `ConcertRemoteDatasource`.

## `/update-config`
Configures Claude Code hooks and permissions.
Use to allow `make gen` or `fvm flutter pub get` without repeated prompts.

## `/fewer-permission-prompts`
Adds frequently used read-only commands to the allowlist.

## Common Workflows

### Adding a new entity
1. Create a Dart class in `lib/features/<feature>/domain/entities/` with `@freezed` + `@JsonSerializable`
2. Run `make gen`
3. Never edit `.freezed.dart` or `.g.dart` directly

### Adding a new API call
1. Add method to the datasource (`*_remote_datasource.dart`)
2. Add method to the repository interface (`*_repository.dart`)
3. Implement in the repository impl (`*_repository_impl.dart`)
4. Expose via a Riverpod provider (`*_providers.dart`) and run `make gen`

### Wiring a new screen
1. Add a route name in `lib/routing/route_names.dart`
2. Register the route in `lib/routes.dart`
3. Create `screens/` and `widgets/` under the feature's `presentation/` folder

### Testing integration with host app
Run from `tkc_core_app` — this package has no standalone entry point.
