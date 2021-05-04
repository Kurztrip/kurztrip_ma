import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountPageState extends Equatable {
  AccountPageState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class FetchingAccountInfo extends AccountPageState {}

class ShowingAccountInfo extends AccountPageState {
  final User user;
  ShowingAccountInfo({@required this.user}) : super([user]);
}

class ErrorState extends AccountPageState {
  final String message;
  ErrorState({@required this.message}) : super([message]);
}
