import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/route_addition_bloc/route_addition_state.dart';

class RouteAdditionBloc extends Bloc<RouteAdditionEvent, RouteAdditionState> {
  RouteAdditionBloc() : super(FetchingList());

  @override
  Stream<RouteAdditionState> mapEventToState(RouteAdditionEvent event) async* {
    if (event is StartFetching) {
      yield FetchingList();
      //llamar metodo de repositorio para obtener lista
      await Future.delayed(Duration(seconds: 2));
      this.add(DBCenterListObtained(dbList: [
        DistributionCenter(
            id: 5,
            address: 'cra 100 12',
            available_space: 100,
            total_space: 200,
            latitude_location: 50,
            longitude_location: 50),
        DistributionCenter(
            id: 4,
            address: 'cra 32 11',
            available_space: 100,
            total_space: 200,
            latitude_location: 50,
            longitude_location: 50),
        DistributionCenter(
            id: 1,
            address: 'cra 10 89',
            available_space: 100,
            total_space: 200,
            latitude_location: 50,
            longitude_location: 50),
        DistributionCenter(
            id: 6,
            address: 'cra 140 23',
            available_space: 100,
            total_space: 200,
            latitude_location: 50,
            longitude_location: 50),
      ]));
    } else if (event is DBCenterListObtained) {
      yield ShowingDBCenterList(index: 0, dbList: event.dbList);
    } else if (event is RadioButtonSelected) {
      yield ShowingDBCenterList(
          index: event.index, dbList: (state as ShowingDBCenterList).dbList);
    } else if (event is CreateButtonPressed) {
      yield CreatingRoute();
      //llamar metodo de repositorio para crear ruta
      await Future.delayed(Duration(seconds: 2));
      this.add(ErrorOccurred(message: "Error de conexión"));
    } else if (event is RouteCreatedSuccessfully) {
      yield Success();
    } else if (event is ErrorOccurred) {
      yield ShowingErrorMessage(message: event.message);
    }
  }
}
