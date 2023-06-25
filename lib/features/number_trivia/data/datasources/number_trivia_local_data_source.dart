// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_architecture/core/error/exceptions.dart';
import 'package:tdd_clean_architecture/core/error/failures.dart';

import 'package:tdd_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final getNumberTriviaFromCached =
        sharedPreferences.getString('number_trivia_cached');
    if (getNumberTriviaFromCached != null) {
      return Future.value(
          NumberTriviaModel.fromJson(json.decode(getNumberTriviaFromCached)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) async {
    sharedPreferences.setString(
        'number_trivia_cached', json.encode(triviaToCache.toJson()));
  }
}
