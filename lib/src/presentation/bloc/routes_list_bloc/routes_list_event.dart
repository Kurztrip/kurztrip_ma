part of 'routes_list_bloc.dart';

abstract class RoutesListEvent extends Equatable {
  const RoutesListEvent();

  @override
  List<Object> get props => [];
}

class GetRoutes extends RoutesListEvent {}

class RefreshRoutes extends RoutesListEvent {}

class DeleteRoutes extends RoutesListEvent {
  final int? id;

  DeleteRoutes(this.id);
}

class RoutesToError extends RoutesListEvent {}
