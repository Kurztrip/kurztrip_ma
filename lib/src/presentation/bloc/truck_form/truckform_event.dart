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
