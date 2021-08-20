import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/delete_route_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/get_routes_use_case.dart';

part 'routes_list_event.dart';
part 'routes_list_state.dart';

class RoutesListBloc extends Bloc<RoutesListEvent, RouteslistState> {
  RoutesListBloc() : super(RouteslistLoading());
  GetRoutesUseCase? getRoutesUseCase = getIt();
  DeleteRouteUseCase? deleteRouteUseCase = getIt();
  @override
  Stream<RouteslistState> mapEventToState(
    RoutesListEvent event,
  ) async* {
    if (event is GetRoutes) {
      yield* (await getRoutesUseCase!()).fold((failure) async* {
        yield RouteslistError();
      }, (routes) async* {
        yield RouteslistShowing(routes);
      });
    } else if (event is RoutesToError) {
      yield RouteslistError();
    } else if (event is RefreshRoutes) {
      yield RouteslistLoading();
    } else if (event is DeleteRoutes) {
      yield* (await deleteRouteUseCase!(event.id!)).fold((failure) async* {
        yield RouteslistError();
      }, (i) async* {
        this.add(RefreshRoutes());
      });
    }
  }
}
