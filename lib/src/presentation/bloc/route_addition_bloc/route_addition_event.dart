import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RouteAdditionEvent extends Equatable {
  RouteAdditionEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class StartFetching extends RouteAdditionEvent {}

class RadioButtonSelected extends RouteAdditionEvent {
  final int index;
  RadioButtonSelected({this.index}) : super([index]);
}

class DBCenterListObtained extends RouteAdditionEvent {
  final List<DistributionCenter> dbList;
  DBCenterListObtained({this.dbList}) : super(dbList);
}

class CreateButtonPressed extends RouteAdditionEvent {
  CreateButtonPressed({int id}) : super([id]);
}

class RouteCreatedSuccessfully extends RouteAdditionEvent {}

class ErrorOccurred extends RouteAdditionEvent {
  final String message;
  ErrorOccurred({this.message}) : super([message]);
}
