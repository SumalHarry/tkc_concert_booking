import 'package:equatable/equatable.dart';

import '../../../domain/entities/concert.dart';

enum ConcertListConcreteState {
  initial,
  loading,
  loaded,
  failure,
}

class ConcertListState extends Equatable {
  const ConcertListState({
    this.concerts = const [],
    this.hasData = false,
    this.state = ConcertListConcreteState.initial,
    this.message = '',
    this.isLoading = false,
  });

  final List<Concert> concerts;
  final bool hasData;
  final ConcertListConcreteState state;
  final String message;
  final bool isLoading;

  const ConcertListState.initial({
    this.concerts = const [],
    this.hasData = false,
    this.state = ConcertListConcreteState.initial,
    this.message = '',
    this.isLoading = false,
  });

  ConcertListState copyWith({
    List<Concert>? concerts,
    bool? hasData,
    ConcertListConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return ConcertListState(
      concerts: concerts ?? this.concerts,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [concerts, hasData, state, message, isLoading];
}
