part of 'route_assignation_page_bloc.dart';

abstract class RouteAssignationPageEvent extends Equatable {
  const RouteAssignationPageEvent([this.properties = const <Object>[]]);

  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class RadioButtonSelected extends RouteAssignationPageEvent {
  final int? index;
  RadioButtonSelected({this.index}) : super([index]);
}

class AssignButtonPressed extends RouteAssignationPageEvent {
  final int routeId;

  AssignButtonPressed(this.routeId);
}

class StartFetching extends RouteAssignationPageEvent {}
