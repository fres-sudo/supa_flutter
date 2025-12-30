import 'package:flutter_test/flutter_test.dart';
import 'package:supa_flutter/core/misc/result.dart';

class _TestException implements Exception {
  const _TestException(this.message);
  final String message;

  @override
  String toString() => '_TestException($message)';
}

void main() {
  group('Result.unwrap', () {
    test('returns value for Ok', () {
      final result = Result<int>.ok(123);
      expect(result.unwrap(), 123);
    });

    test('throws contained exception for Error', () {
      final ex = const _TestException('boom');
      final result = Result<int>.error(ex);

      expect(() => result.unwrap(), throwsA(same(ex)));
    });
  });
}


