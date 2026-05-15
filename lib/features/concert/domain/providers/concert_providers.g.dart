// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concert_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(concertRemoteDataSource)
final concertRemoteDataSourceProvider = ConcertRemoteDataSourceProvider._();

final class ConcertRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ConcertRemoteDataSource,
          ConcertRemoteDataSource,
          ConcertRemoteDataSource
        >
    with $Provider<ConcertRemoteDataSource> {
  ConcertRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'concertRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$concertRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ConcertRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConcertRemoteDataSource create(Ref ref) {
    return concertRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConcertRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConcertRemoteDataSource>(value),
    );
  }
}

String _$concertRemoteDataSourceHash() =>
    r'94d39ccdadf4bf394f546df096a0748dc0eb3949';

@ProviderFor(concertRepository)
final concertRepositoryProvider = ConcertRepositoryProvider._();

final class ConcertRepositoryProvider
    extends
        $FunctionalProvider<
          ConcertRepository,
          ConcertRepository,
          ConcertRepository
        >
    with $Provider<ConcertRepository> {
  ConcertRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'concertRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$concertRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConcertRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConcertRepository create(Ref ref) {
    return concertRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConcertRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConcertRepository>(value),
    );
  }
}

String _$concertRepositoryHash() => r'815ffb6763ccd6d2e2e911230d43c4cf7cba2e55';
