import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/error/exceptions.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixture/fixture_reader.dart';
import 'number_trivia_remote_data_source.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late final MockClient mockHttpClient;
  late final NumberTriviaRemoteDataSourceImpl remoteDataSourceImpl;

  setUpAll(() {
    mockHttpClient = MockClient();
    remoteDataSourceImpl =
        NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModels =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    void whenResponseIs200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    }

    void whenResponseIs404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

    test(
      'should perform GET request to the endpoint',
      () async {
        // arrange
        whenResponseIs200();

        // act
        remoteDataSourceImpl.getConcreteNumberTrivia(tNumber);

        // assert
        verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
            headers: {"Content-Type": "application/json"}));
      },
    );

    test(
      'should return a value if the status code is 200',
      () async {
        // arrange
        whenResponseIs200();

        // act
        final results =
            await remoteDataSourceImpl.getConcreteNumberTrivia(tNumber);

        // assert
        expect(results, equals(tNumberTriviaModels));
      },
    );

    test(
      'should throw ServerException if response code is 404 or other',
      () async {
        // arrange
        whenResponseIs404();
        // act
        final call = remoteDataSourceImpl.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), const TypeMatcher<ServerException>());
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModels =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    void whenResponseIs200() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    }

    void whenResponseIs404() {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));
    }

    test(
      'should perform GET request to the endpoint',
      () async {
        // arrange
        whenResponseIs200();

        // act
        remoteDataSourceImpl.getRandomNumberTrivia();

        // assert
        verify(mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
            headers: {"Content-Type": "application/json"}));
      },
    );

    test(
      'should return a value if the status code is 200',
      () async {
        // arrange
        whenResponseIs200();

        // act
        final results = await remoteDataSourceImpl.getRandomNumberTrivia();

        // assert
        expect(results, equals(tNumberTriviaModels));
      },
    );

    test(
      'should throw ServerException if response code is 404 or other',
      () async {
        // arrange
        whenResponseIs404();
        // act
        final call = remoteDataSourceImpl.getRandomNumberTrivia;
        // assert
        expect(() => call(), const TypeMatcher<ServerException>());
      },
    );
  });
}
