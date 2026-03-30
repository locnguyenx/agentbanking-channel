import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

void main() {
  group('OpenApiValidators', () {
    group('length', () {
      test('returns null if value is null', () {
        expect(OpenApiValidators.length(null), isNull);
      });

      test('returns null if length is within limits', () {
        expect(OpenApiValidators.length('test', minLen: 2, maxLen: 10), isNull);
      });

      test('returns error if length is below minimum', () {
        expect(OpenApiValidators.length('a', minLen: 2), 'Must be at least 2 characters');
      });

      test('returns error if length exceeds maximum', () {
        expect(OpenApiValidators.length('toolong', maxLen: 5), 'Cannot exceed 5 characters');
      });
    });

    group('minMax', () {
      test('returns null if value is null or empty', () {
        expect(OpenApiValidators.minMax(null), isNull);
        expect(OpenApiValidators.minMax(''), isNull);
      });

      test('returns null if value is within limits', () {
        expect(OpenApiValidators.minMax('50.00', min: 10.00, max: 100.00), isNull);
      });

      test('returns error if value is not a valid number', () {
        expect(OpenApiValidators.minMax('abc'), 'Invalid number');
      });

      test('returns error if value is below minimum', () {
        expect(OpenApiValidators.minMax('5.00', min: 10.00), 'Amount must be at least 10.0');
      });

      test('returns error if value exceeds maximum', () {
        expect(OpenApiValidators.minMax('150.00', max: 100.00), 'Amount cannot exceed 100.0');
      });
    });
  });
}
