// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String numberString;
  const GetConcreteNumberTriviaEvent({
    required this.numberString,
  });
}

class GetReandomNumberTriviaEvent extends NumberTriviaEvent { }
