part of 'route_assignation_page_bloc.dart';

abstract class RouteAssignationPageState extends Equatable {
  const RouteAssignationPageState([this.properties = const <Object>[]]);

  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class RouteassignationpageInitial extends RouteAssignationPageState {}

class DataFetched extends RouteAssignationPageState {
  final int index;
  final List<TrackingRoute>? routes;

  DataFetched(
    this.routes,
    this.index,
  ) : super([routes, index]);
}

class ShowingErrorMessage extends RouteAssignationPageState {
  final String? message;
  ShowingErrorMessage({this.message = 'error'}) : super([message]);
}

class Success extends RouteAssignationPageState {}

class Loading extends RouteAssignationPageState {}

class FetchingDC extends RouteAssignationPageState {}

class FetchingRoutes extends RouteAssignationPageState {
  final int dcIndex;
  final List<DistributionCenter>? distributionCenters;

  FetchingRoutes(this.dcIndex, this.distributionCenters)
      : super([distributionCenters, dcIndex]);
}

class ShowingDBCenterList extends RouteAssignationPageState {
  final int? index;
  final List<DistributionCenter>? distributionCenters;
  ShowingDBCenterList({this.index, this.distributionCenters})
      : super([index, distributionCenters]);
}
