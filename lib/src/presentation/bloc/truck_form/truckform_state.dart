part of 'truckform_bloc.dart';

abstract class TruckformState extends Equatable {
  const TruckformState([this.properties = const <dynamic>[]]) : super();
  final List properties;
  @override
  List<Object?> get props => properties;
}

class TruckformLoading extends TruckformState {}

class TruckformSuccess extends TruckformState {}

class TruckformShowing extends TruckformState {
  final int? id;
  final String? error;
  final String? register;
  final double? volumeCapacity;
  final double? weightCapacity;
  final double? fuelCapacity;
  final String? fuelType;
  final double? fuelPerKilometer;
  final double? fuel;
  final int? warehouse;
  final String? state;

  TruckformShowing({
    this.fuel,
    this.id,
    this.error,
    this.register,
    this.volumeCapacity,
    this.weightCapacity,
    this.fuelCapacity,
    this.fuelType,
    this.fuelPerKilometer,
    this.warehouse,
    this.state,
  }) : super([
          fuel,
          id,
          error,
          register,
          volumeCapacity,
          weightCapacity,
          fuelCapacity,
          fuelType,
          fuelPerKilometer,
          warehouse,
          state
        ]);
  TruckformShowing copyWith({
    String? register,
    String? error,
    double? volumeCapacity,
    double? weightCapacity,
    double? fuelCapacity,
    double? fuel,
    String? fuelType,
    double? fuelPerKilometer,
    int? warehouse,
    String? state,
  }) {
    return TruckformShowing(
      id: this.id,
      fuel: fuel != null ? fuel : this.fuel,
      error: error,
      register: register != null ? register : this.register,
      volumeCapacity:
          volumeCapacity != null ? volumeCapacity : this.volumeCapacity,
      weightCapacity:
          weightCapacity != null ? weightCapacity : this.weightCapacity,
      fuelCapacity: fuelCapacity != null ? fuelCapacity : this.fuelCapacity,
      fuelType: fuelType != null ? fuelType : this.fuelType,
      fuelPerKilometer:
          fuelPerKilometer != null ? fuelPerKilometer : this.fuelPerKilometer,
      warehouse: warehouse != null ? warehouse : this.warehouse,
      state: state != null ? state : this.state,
    );
  }
}
