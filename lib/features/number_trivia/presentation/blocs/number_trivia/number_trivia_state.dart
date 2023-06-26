// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia numberTriviaEntity;
  const Loaded({
    required this.numberTriviaEntity,
  });

  @override
  List<Object> get props => [numberTriviaEntity];
}

class Error extends NumberTriviaState {
  final String msg;
  const Error({
    required this.msg,
  });

  @override
  List<Object> get props => [msg];
}
