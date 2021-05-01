import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String error;

  Failure(this.error);

  @override
  List<Object> get props => [error];
}

// General failures
class ServerFailure extends Failure {

  ServerFailure(String error):super(error);
}
