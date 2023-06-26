import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/utils/input_converter.dart';

void main() {
  late final InputConverter inputConverter;
  setUpAll(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test(
      'should convert string to Integer',
      () async {
        // arrange
        const tNumber = '123';

        // act
        final results = inputConverter.stringToUnsignedInteger(tNumber);

        // assert
        expect(results, const Right(123));
      },
    );
    test(
      'should return format exception if the string is not unsigned integer',
      () async {
        // arrange
        const tNumber = 'abc';

        // act
        final results = inputConverter.stringToUnsignedInteger(tNumber);

        // assert
        expect(results, Left(InvalidInputFailure()));
      },
    );
    test(
      'should return format exception if the string is negative unsigned integer',
      () async {
        // arrange
        const tNumber = '-123';

        // act
        final results = inputConverter.stringToUnsignedInteger(tNumber);

        // assert
        expect(results, Left(InvalidInputFailure()));
      },
    );
  });
}
