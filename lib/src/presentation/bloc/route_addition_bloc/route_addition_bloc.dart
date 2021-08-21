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
      //llamar metodo de repositorio para obtener lista
      // await Future.delayed(Duration(seconds: 2));
      // this.add(DBCenterListObtained(dbList: [
      //   DistributionCenter(
      //       id: 5,
      //       address: 'cra 100 12',
      //       available_space: 100,
      //       total_space: 200,
      //       latitude_location: 50,
      //       longitude_location: 50),
      //   DistributionCenter(
      //       id: 4,
      //       address: 'cra 32 11',
      //       available_space: 100,
      //       total_space: 200,
      //       latitude_location: 50,
      //       longitude_location: 50),
      //   DistributionCenter(
      //       id: 1,
      //       address: 'cra 10 89',
      //       available_space: 100,
      //       total_space: 200,
      //       latitude_location: 50,
      //       longitude_location: 50),
      //   DistributionCenter(
      //       id: 6,
      //       address: 'cra 140 23',
      //       available_space: 100,
      //       total_space: 200,
      //       latitude_location: 50,
      //       longitude_location: 50),
      // ]));
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
