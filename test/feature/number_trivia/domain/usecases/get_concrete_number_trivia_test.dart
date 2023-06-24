import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/repository/number_trivia_repository.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository =
      MockNumberTriviaRepository();
  GetConcreteNumberTrivia usecase =
      GetConcreteNumberTrivia(repository: mockNumberTriviaRepository);

  test(
    'should get trivia number from the repository',
    () async {
      // arrange
      final testNumb = 1;
      final testNumberTrivia = NumberTrivia(text: 'test', number: 1);
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(number: testNumb))
          .thenAnswer((_) async => Right(testNumberTrivia));

      // act
      final result = await usecase.execute(number: testNumb);
      // assert
      expect(result, Right(testNumberTrivia));
      verify(
          mockNumberTriviaRepository.getConcreteNumberTrivia(number: testNumb));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
