// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_bookings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyBookingsNotifier)
final myBookingsProvider = MyBookingsNotifierProvider._();

final class MyBookingsNotifierProvider
    extends $NotifierProvider<MyBookingsNotifier, MyBookingsState> {
  MyBookingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myBookingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myBookingsNotifierHash();

  @$internal
  @override
  MyBookingsNotifier create() => MyBookingsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyBookingsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyBookingsState>(value),
    );
  }
}

String _$myBookingsNotifierHash() =>
    r'3dabcc6132b66cb20301873a837fb766405d47f6';

abstract class _$MyBookingsNotifier extends $Notifier<MyBookingsState> {
  MyBookingsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<MyBookingsState, MyBookingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MyBookingsState, MyBookingsState>,
              MyBookingsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
