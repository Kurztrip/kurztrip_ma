import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainPageState extends Equatable {
  MainPageState([this.properties = const <Object>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class TruckTab extends MainPageState {}

class PackageTab extends MainPageState {}

class RouteTab extends MainPageState {}

class AccountTab extends MainPageState {}

class ErrorState extends MainPageState {
  final String message;
  ErrorState({this.message = 'error'}) : super([message]);
}
