import 'package:flutter_test/flutter_test.dart';
import 'package:miniapp_concert/core/error/failure.dart';
import 'package:miniapp_concert/core/network/models/app_exception.dart';
import 'package:miniapp_concert/core/network/models/either.dart';
import 'package:miniapp_concert/core/network/models/unit.dart';

void main() {
  group('Either', () {
    test('Right.fold calls onRight', () {
      const either = Right<String, int>(7);
      expect(either.fold((_) => -1, (r) => r), 7);
    });

    test('Left.fold calls onLeft', () {
      const either = Left<String, int>('err');
      expect(either.fold((l) => l, (_) => ''), 'err');
    });

    test('Right isRight/isLeft flags', () {
      const either = Right<String, int>(1);
      expect(either.isRight, isTrue);
      expect(either.isLeft, isFalse);
    });

    test('Left isRight/isLeft flags', () {
      const either = Left<String, int>('e');
      expect(either.isLeft, isTrue);
      expect(either.isRight, isFalse);
    });

    test('fold can transform to a different type', () {
      const either = Right<String, int>(10);
      expect(either.fold((_) => false, (r) => r.isEven), isTrue);
    });
  });

  group('AppException', () {
    test('instances with same message and code are equal', () {
      const a = AppException('boom', code: '500');
      const b = AppException('boom', code: '500');
      expect(a, equals(b));
    });

    test('instances with different codes are not equal', () {
      const a = AppException('boom', code: '400');
      const b = AppException('boom', code: '500');
      expect(a, isNot(equals(b)));
    });

    test('code defaults to null', () {
      const e = AppException('boom');
      expect(e.code, isNull);
    });

    test('toString format', () {
      const e = AppException('not found', code: '404');
      expect(e.toString(), 'AppException(404): not found');
    });

    test('is an Exception', () {
      const e = AppException('boom');
      expect(e, isA<Exception>());
    });
  });

  group('Unit', () {
    test('unit constant is a Unit', () {
      expect(unit, isA<Unit>());
    });

    test('unit is identical to itself', () {
      expect(identical(unit, unit), isTrue);
    });
  });

  group('Failure', () {
    test('Failure.exception creates a FailureFromAppException', () {
      const failure = Failure.exception(AppException('bad'));
      expect(failure, isA<FailureFromAppException>());
    });

    test('message getter returns the wrapped exception message', () {
      const failure = FailureFromAppException(AppException('network down'));
      expect(failure.message, 'network down');
    });

    test('two failures wrapping equal exceptions are equal', () {
      const a = Failure.exception(AppException('x', code: '1'));
      const b = Failure.exception(AppException('x', code: '1'));
      expect(a, equals(b));
    });

    test('failures wrapping different exceptions are not equal', () {
      const a = Failure.exception(AppException('x'));
      const b = Failure.exception(AppException('y'));
      expect(a, isNot(equals(b)));
    });
  });
}
