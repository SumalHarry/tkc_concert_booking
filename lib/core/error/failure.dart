import 'package:equatable/equatable.dart';

import '../network/failures/app_exception.dart';

sealed class Failure extends Equatable {
  const Failure();

  const factory Failure.exception(AppException exception) =
      FailureFromAppException;

  @override
  List<Object?> get props => [];
}

final class FailureFromAppException extends Failure {
  const FailureFromAppException(this.exception);

  final AppException exception;

  @override
  List<Object?> get props => [exception];

  String get message => exception.message;
}
