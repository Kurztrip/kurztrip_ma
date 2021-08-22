import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';

part 'route_assignation_page_event.dart';
part 'route_assignation_page_state.dart';

class RouteAssignationPageBloc
    extends Bloc<RouteAssignationPageEvent, RouteAssignationPageState> {
  RouteAssignationPageBloc() : super(RouteassignationpageInitial());

  @override
  Stream<RouteAssignationPageState> mapEventToState(
    RouteAssignationPageEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
