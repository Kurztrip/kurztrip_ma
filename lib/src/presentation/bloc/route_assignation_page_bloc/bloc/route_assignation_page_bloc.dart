import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/assign_route_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/get_free_routes_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/get_routes_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'route_assignation_page_event.dart';
part 'route_assignation_page_state.dart';

class RouteAssignationPageBloc
    extends Bloc<RouteAssignationPageEvent, RouteAssignationPageState> {
  RouteAssignationPageBloc() : super(RouteassignationpageInitial());
  GetFreeRoutesUseCase getFreeRoutesUseCase = getIt();
  GetRoutesUseCase getRoutesUseCase = getIt();
  AssignRouteUseCase assignRouteUseCase = getIt();
  SharedPreferences prefs = getIt();

  @override
  Stream<RouteAssignationPageState> mapEventToState(
    RouteAssignationPageEvent event,
  ) async* {
    if (event is StartFetching) {
      yield Loading();
      yield* (await getRoutesUseCase()).fold((error) async* {
        yield ShowingErrorMessage(message: error.error);
      }, (routes) async* {
        yield* (await getRoutesUseCase()).fold((error) async* {
          yield ShowingErrorMessage(message: error.error);
        }, (freeRoutes) async* {
          List<TrackingRoute> result = routes
              .where((element) => freeRoutes.contains(element.truck_id))
              .toList();
          yield DataFetched(routes, 0);
        });
      });
    } else if (event is RadioButtonSelected) {
      yield DataFetched((state as DataFetched).routes, event.index!);
    } else if (event is AssignButtonPressed) {
      User user = User.fromJson(jsonDecode(prefs.getString('user')!));
      yield* (await assignRouteUseCase(user.id!, event.routeId)).fold(
          (error) async* {
        yield ShowingErrorMessage(message: error.error);
      }, (assign) async* {
        yield Success();
      });
    }
  }
}
