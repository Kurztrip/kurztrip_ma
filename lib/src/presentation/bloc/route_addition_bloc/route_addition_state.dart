import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RouteAdditionState extends Equatable {
  RouteAdditionState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class FetchingList extends RouteAdditionState {}

class CreatingRoute extends RouteAdditionState {}

class ShowingDBCenterList extends RouteAdditionState {
  final int index;
  final List<DistributionCenter> dbList;
  ShowingDBCenterList({this.index, this.dbList}) : super([index, dbList]);
}

class ShowingErrorMessage extends RouteAdditionState {
  final String message;
  ShowingErrorMessage({this.message = 'error'}) : super([message]);
}

class Success extends RouteAdditionState {}
