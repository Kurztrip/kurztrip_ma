part of 'route_assignation_page_bloc.dart';

abstract class RouteAssignationPageState extends Equatable {
  const RouteAssignationPageState([this.properties = const <Object>[]]);

  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class RouteassignationpageInitial extends RouteAssignationPageState {}

class DataFetched extends RouteAssignationPageState {
  final int dcIndex;
  final int routeIndex;
  final List<DistributionCenter>? distributionCenters;
  final List<TrackingRoute>? routes;

  DataFetched(
    this.distributionCenters,
    this.routes,
    this.dcIndex,
    this.routeIndex,
  ) : super([distributionCenters, routes, dcIndex, routeIndex]);
}

class ShowingErrorMessage extends RouteAssignationPageState {
  final String? message;
  ShowingErrorMessage({this.message = 'error'}) : super([message]);
}

class Success extends RouteAssignationPageState {}

class FetchingDC extends RouteAssignationPageState {}

class FetchingRoutes extends RouteAssignationPageState {
  final int dcIndex;
  final List<DistributionCenter>? distributionCenters;

  FetchingRoutes(this.dcIndex, this.distributionCenters)
      : super([distributionCenters, dcIndex]);
}
