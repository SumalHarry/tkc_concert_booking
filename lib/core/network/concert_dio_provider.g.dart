// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concert_dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Core App overrides this provider with an authenticated Dio before mounting
/// [ConcertApp].

@ProviderFor(concertDio)
final concertDioProvider = ConcertDioProvider._();

/// Core App overrides this provider with an authenticated Dio before mounting
/// [ConcertApp].

final class ConcertDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Core App overrides this provider with an authenticated Dio before mounting
  /// [ConcertApp].
  ConcertDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'concertDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$concertDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return concertDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$concertDioHash() => r'0683ad44ffd41b326b70cc3accc3149797cbf945';
