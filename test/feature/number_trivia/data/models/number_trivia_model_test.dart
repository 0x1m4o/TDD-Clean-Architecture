import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 1);
  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // arrange
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should get an Integer NumberTrivia.fromJson',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );
    test(
      'should get a double NumberTrivia.fromJson',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));

        // act
        final result = NumberTriviaModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );
  });
  group('toJson', () {
    test(
      'should get an Integer NumberTrivia.toJson',
      () async {
        // act
        final result = tNumberTriviaModel.toJson();

        // assert
        final expectedMap = {
          "text": "test",
          "number": 1,
        };
        expect(result, equals(expectedMap));
      },
    );
    test(
      'should get a double NumberTrivia.toJson',
      () async {
        // act
        final result = tNumberTriviaModel.toJson();

        // assert
        final expectedMap = {
          "text": "test",
          "number": 1.0,
        };
        expect(result, equals(expectedMap));
      },
    );
  });
}
