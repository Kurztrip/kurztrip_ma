import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/create_route_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/use_cases/get_distribution_centers_use_case.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_state.dart';

class RouteAdditionBloc extends Bloc<RouteAdditionEvent, RouteAdditionState> {
  RouteAdditionBloc() : super(FetchingList());
  GetDistributionCentersUseCase getDistributionCentersUseCase = getIt();
  CreateRouteUseCase createRouteUseCase = getIt();
  @override
  Stream<RouteAdditionState> mapEventToState(RouteAdditionEvent event) async* {
    if (event is StartFetching) {
      yield Loading();
      yield* (await getDistributionCentersUseCase()).fold((error) async* {
        yield ShowingErrorMessage(message: error.error);
      }, (distributionCenters) async* {
        debugPrint('distributionCenters.toString()');
        yield ShowingDBCenterList(index: 0, dbList: distributionCenters);
      });
    } else if (event is DBCenterListObtained) {
      yield ShowingDBCenterList(index: 0, dbList: event.dbList);
    } else if (event is RadioButtonSelected) {
      yield ShowingDBCenterList(
          index: event.index, dbList: (state as ShowingDBCenterList).dbList);
    } else if (event is CreateButtonPressed) {
      yield Loading();
      yield* (await createRouteUseCase(event.id)).fold((e) async* {
        yield ShowingErrorMessage(message: e.toString());
      }, (res) async* {
        yield Success();
      });
    } else if (event is ErrorOccurred) {
      yield ShowingErrorMessage(message: event.message);
    }
  }
}
