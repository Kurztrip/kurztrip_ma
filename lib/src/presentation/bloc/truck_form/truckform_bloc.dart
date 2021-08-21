import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/create_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/get_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/update_truck_use_case.dart';

part 'truckform_event.dart';
part 'truckform_state.dart';

class TruckformBloc extends Bloc<TruckformEvent, TruckformState> {
  TruckformBloc({this.edit}) : super(TruckformShowing()) {
    if (edit != null) {
      this.add(GetTruckAutofill());
      init(edit);
    }
  }
  Future<void> init(int? id) async {
    Either<Failure, Truck> result = await getTruckUseCase!(id!);
    result.fold((failure) {
      this.add(ToTruckError("Error al obtener el camion"));
    }, (truck) {
      this.add(TruckformAutofill(
        truck.id,
        truck.registration,
        truck.volume_capacity,
        truck.weight_capacity,
        truck.fuel_capacity,
        truck.fuel_type == "Gasoline" ? "Gasolina" : truck.fuel_type,
        truck.fuel_by_kilometer,
        truck.warehouse,
        truck.status,
        truck.fuel,
      ));
    });
  }

  final int? edit;

  final GetTruckUseCase? getTruckUseCase = getIt();
  final CreateTruckUseCase? createTruckUseCase = getIt();
  final UpdateTruckUseCase? updateTruckUseCase = getIt();

  @override
  Stream<TruckformState> mapEventToState(
    TruckformEvent event,
  ) async* {
    if (event is GetTruckAutofill) {
      yield TruckformLoading();
    } else if (event is UpdateFuelCapacity) {
      yield (state as TruckformShowing)
          .copyWith(fuelCapacity: event.fuelCapacity);
    } else if (event is UpdateFuel) {
      yield (state as TruckformShowing).copyWith(fuel: event.fuel);
    } else if (event is UpdateFuelPerKilometer) {
      yield (state as TruckformShowing)
          .copyWith(fuelPerKilometer: event.fuelPerKilometer);
    } else if (event is UpdateFuelType) {
      yield (state as TruckformShowing).copyWith(fuelType: event.fuelType);
    } else if (event is UpdateRegister) {
      yield (state as TruckformShowing).copyWith(register: event.register);
    } else if (event is UpdateState) {
      String status;
      switch (event.state) {
        case 'En Ruta':
          status = "InRoute";
          break;
        case 'En Mantenimiento':
          status = "Maintenance";
          break;
        default:
          status = "Available";
      }
      yield (state as TruckformShowing).copyWith(state: status);
    } else if (event is UpdateVolumeCapacity) {
      yield (state as TruckformShowing)
          .copyWith(volumeCapacity: event.volumeCapacity);
    } else if (event is UpdateWarehouse) {
      yield (state as TruckformShowing).copyWith(warehouse: event.warehouse);
    } else if (event is UpdateWeightCapacity) {
      yield (state as TruckformShowing)
          .copyWith(weightCapacity: event.weightCapacity);
    } else if (event is TruckformAutofill) {
      yield TruckformShowing(
          id: event.id,
          fuel: event.fuel,
          register: event.register,
          volumeCapacity: event.volumeCapacity,
          weightCapacity: event.weightCapacity,
          fuelCapacity: event.fuelCapacity,
          fuelType: event.fuelType,
          fuelPerKilometer: event.fuelPerKilometer,
          warehouse: event.warehouse,
          state: event.state);
    } else if (event is SubmitTruck) {
      TruckformShowing current = state as TruckformShowing;
      Truck truck = Truck(
        id: current.id,
        status: current.state != null ? current.state : "Available",
        registration: current.register,
        volume_capacity: current.volumeCapacity,
        weight_capacity: current.weightCapacity,
        fuel_capacity: current.fuelCapacity,
        fuel_type:
            current.fuelType == "Gasolina" ? "Gasoline" : current.fuelType,
        fuel_by_kilometer: current.fuelPerKilometer,
        warehouse: current.warehouse,
        fuel: current.fuel,
      );
      yield TruckformLoading();

      if (truck.id == null) {
        Either<Failure, Truck> result = await createTruckUseCase!(Params(truck));
        yield* result.fold((failure) async* {
          yield current.copyWith(
              error: "operación fallida, por favor revisa tu conexión");
        }, (truck) async* {
          yield TruckformSuccess();
        });
      } else {
        Either<Failure, int> result =
            await (updateTruckUseCase!(UpdateParams(truck)) as FutureOr<Either<Failure, int>>);
        yield* result.fold((failure) async* {
          yield current.copyWith(
              error: "operación fallida, por favor revisa tu conexión");
        }, (truck) async* {
          yield TruckformSuccess();
        });
      }
    } else if (event is ToTruckError) {
      yield (state as TruckformShowing).copyWith(error: event.error);
    }
  }
}
