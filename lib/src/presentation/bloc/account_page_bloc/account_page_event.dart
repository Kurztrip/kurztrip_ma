import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountPageEvent extends Equatable {
  AccountPageEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class StartFetching extends AccountPageEvent {}

class AccountInfoObtained extends AccountPageEvent {
  final User user;
  AccountInfoObtained({required this.user}) : super([user]);
}

class ErrorOccurred extends AccountPageEvent {
  final String message;
  ErrorOccurred({required this.message}) : super([message]);
}

class LogOut extends AccountPageEvent {}
