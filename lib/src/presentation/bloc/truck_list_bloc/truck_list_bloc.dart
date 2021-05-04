import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/delete_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/get_trucks_use_cases.dart';

part 'truck_list_event.dart';
part 'truck_list_state.dart';

class TruckListBloc extends Bloc<TruckListEvent, TruckListState> {
  final GetTrucksUseCase getTrucksUseCase = getIt();
  final DeleteTruckUseCase deleteTruckUseCase = getIt();
  TruckListBloc() : super(TrucklistLoading());

  @override
  Stream<TruckListState> mapEventToState(
    TruckListEvent event,
  ) async* {
    if (event is DeleteTruck) {
      Either<Failure, bool> result = await deleteTruckUseCase(event.id);
      yield* result.fold((failure) async* {
        yield TrucklistShowing((state as TrucklistShowing).trucks,
            error: "Error al eliminar el paquete");
      }, (truck) async* {
        yield TrucklistShowing((state as TrucklistShowing).trucks,
            success: "Paquete eliminado correctamente");
        this.add(TruckListRefresh());
      });
    } else if (event is GetAllTrucks) {
      yield* (await getTrucksUseCase()).fold((error) async* {
        yield TrucklistError(error.error);
      }, (trucks) async* {
        yield TrucklistShowing(trucks);
      });
    } else if (event is TruckListRefresh) {
      yield TrucklistLoading();
    } else {}
  }
}
