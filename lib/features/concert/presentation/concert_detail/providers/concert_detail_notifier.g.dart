// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concert_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConcertDetailNotifier)
final concertDetailProvider = ConcertDetailNotifierFamily._();

final class ConcertDetailNotifierProvider
    extends $NotifierProvider<ConcertDetailNotifier, ConcertDetailState> {
  ConcertDetailNotifierProvider._({
    required ConcertDetailNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'concertDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$concertDetailNotifierHash();

  @override
  String toString() {
    return r'concertDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ConcertDetailNotifier create() => ConcertDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConcertDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConcertDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ConcertDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$concertDetailNotifierHash() =>
    r'ee24091d996cb5870e1a81feb693d5a1759df07c';

final class ConcertDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ConcertDetailNotifier,
          ConcertDetailState,
          ConcertDetailState,
          ConcertDetailState,
          int
        > {
  ConcertDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'concertDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConcertDetailNotifierProvider call(int concertId) =>
      ConcertDetailNotifierProvider._(argument: concertId, from: this);

  @override
  String toString() => r'concertDetailProvider';
}

abstract class _$ConcertDetailNotifier extends $Notifier<ConcertDetailState> {
  late final _$args = ref.$arg as int;
  int get concertId => _$args;

  ConcertDetailState build(int concertId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ConcertDetailState, ConcertDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ConcertDetailState, ConcertDetailState>,
              ConcertDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
