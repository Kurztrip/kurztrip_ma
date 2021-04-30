import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'truckform_event.dart';
part 'truckform_state.dart';

class TruckformBloc extends Bloc<TruckformEvent, TruckformState> {
  TruckformBloc() : super(TruckformShowing());

  @override
  Stream<TruckformState> mapEventToState(
    TruckformEvent event,
  ) async* {
    if (event is UpdateFuelCapacity) {
      yield (state as TruckformShowing)
          .copyWith(fuelCapacity: event.fuelCapacity);
    } else if (event is UpdateFuelPerKilometer) {
      yield (state as TruckformShowing)
          .copyWith(fuelPerKilometer: event.fuelPerKilometer);
    } else if (event is UpdateFuelType) {
      yield (state as TruckformShowing).copyWith(fuelType: event.fuelType);
    } else if (event is UpdateRegister) {
      yield (state as TruckformShowing).copyWith(register: event.register);
    } else if (event is UpdateState) {
      yield (state as TruckformShowing).copyWith(state: event.state);
    } else if (event is UpdateVolumeCapacity) {
      yield (state as TruckformShowing)
          .copyWith(volumeCapacity: event.volumeCapacity);
    } else if (event is UpdateWarehouse) {
      yield (state as TruckformShowing).copyWith(warehouse: event.warehouse);
    } else if (event is UpdateWeightCapacity) {
      yield (state as TruckformShowing)
          .copyWith(weightCapacity: event.weightCapacity);
    }
  }
}
