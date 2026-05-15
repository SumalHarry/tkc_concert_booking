// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concert_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConcertListNotifier)
final concertListProvider = ConcertListNotifierProvider._();

final class ConcertListNotifierProvider
    extends $NotifierProvider<ConcertListNotifier, ConcertListState> {
  ConcertListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'concertListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$concertListNotifierHash();

  @$internal
  @override
  ConcertListNotifier create() => ConcertListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConcertListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConcertListState>(value),
    );
  }
}

String _$concertListNotifierHash() =>
    r'c4d87f20f10712d70ed10efd8ac56ef6fc24b628';

abstract class _$ConcertListNotifier extends $Notifier<ConcertListState> {
  ConcertListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ConcertListState, ConcertListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConcertListState, ConcertListState>,
              ConcertListState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
