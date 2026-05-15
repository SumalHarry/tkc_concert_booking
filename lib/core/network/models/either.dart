sealed class Either<L, R> {
  const Either();

  bool get isRight => this is Right<L, R>;
  bool get isLeft => this is Left<L, R>;

  T fold<T>(T Function(L l) left, T Function(R r) right);
}

final class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;

  @override
  T fold<T>(T Function(L l) left, T Function(R r) right) => left(value);
}

final class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;

  @override
  T fold<T>(T Function(L l) left, T Function(R r) right) => right(value);
}
