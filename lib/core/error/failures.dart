// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  List properties = <dynamic>[];
  Failure({required this.properties});

  @override
  List<Object> get props => [properties];
}
