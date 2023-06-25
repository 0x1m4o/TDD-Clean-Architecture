import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_architecture/core/error/exceptions.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixture/fixture_reader.dart';
import 'number_trivia_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  final tNumberTriviaModels = NumberTriviaModel(text: 'test', number: 1);
  late final MockSharedPreferences mockSharedPreferences;
  late final NumberTriviaLocalDataSourceImpl localDataSource;
  setUpAll(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);

    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModels =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
      'should return NumberTrivia from SharedPreferences when there is cached data',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final results = await localDataSource.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString('number_trivia_cached'));
        expect(results, equals(tNumberTriviaModels));
      },
    );
    test(
      'should throw cache exception when there is no cached data',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = localDataSource.getLastNumberTrivia;
        // assert
        expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    test(
      'should call SharedPreference to cache the data',
      () async {
        // act

        localDataSource.cacheNumberTrivia(tNumberTriviaModels);

        // assert
        final expectedJsonString = json.encode(tNumberTriviaModels.toJson());
        verify(mockSharedPreferences.setString(
            'number_trivia_cached', expectedJsonString));
      },
    );
  });
}
