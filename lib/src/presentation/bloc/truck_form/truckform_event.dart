part of 'truckform_bloc.dart';

abstract class TruckformEvent extends Equatable {
  const TruckformEvent();

  @override
  List<Object> get props => [];
}

class UpdateRegister extends TruckformEvent {
  final String register;

  const UpdateRegister(this.register);
}

class UpdateVolumeCapacity extends TruckformEvent {
  final double volumeCapacity;

  const UpdateVolumeCapacity(this.volumeCapacity);
}

class UpdateWeightCapacity extends TruckformEvent {
  final double weightCapacity;

  const UpdateWeightCapacity(this.weightCapacity);
}

class UpdateFuelCapacity extends TruckformEvent {
  final double fuelCapacity;

  const UpdateFuelCapacity(this.fuelCapacity);
}

class UpdateFuel extends TruckformEvent {
  final double fuel;

  const UpdateFuel(this.fuel);
}

class UpdateFuelType extends TruckformEvent {
  final String fuelType;

  const UpdateFuelType(this.fuelType);
}

class UpdateFuelPerKilometer extends TruckformEvent {
  final double fuelPerKilometer;

  const UpdateFuelPerKilometer(this.fuelPerKilometer);
}

class UpdateWarehouse extends TruckformEvent {
  final int warehouse;

  const UpdateWarehouse(this.warehouse);
}

class UpdateState extends TruckformEvent {
  final String state;

  const UpdateState(this.state);
}

class SubmitTruck extends TruckformEvent {}

class GetTruckAutofill extends TruckformEvent {}

class ToTruckError extends TruckformEvent {
  final String error;

  ToTruckError(this.error);
}

class TruckformAutofill extends TruckformEvent {
  final int? id;
  final String? register;
  final double? volumeCapacity;
  final double? weightCapacity;
  final double? fuelCapacity;
  final String? fuelType;
  final double? fuelPerKilometer;
  final int? warehouse;
  final String? state;
  final double? fuel;

  const TruckformAutofill(
    this.id,
    this.register,
    this.volumeCapacity,
    this.weightCapacity,
    this.fuelCapacity,
    this.fuelType,
    this.fuelPerKilometer,
    this.warehouse,
    this.state,
    this.fuel,
  );
}
