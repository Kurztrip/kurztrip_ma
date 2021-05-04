part of 'routes_list_bloc.dart';

abstract class RouteslistState extends Equatable {
  const RouteslistState();

  @override
  List<Object> get props => [];
}

class RouteslistLoading extends RouteslistState {}

class RouteslistError extends RouteslistState {}

class RouteslistShowing extends RouteslistState {
  final List<TrackingRoute> routes;

  RouteslistShowing(this.routes);
}
