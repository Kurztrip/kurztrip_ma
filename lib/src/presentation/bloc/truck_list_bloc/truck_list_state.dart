part of 'truck_list_bloc.dart';

abstract class TruckListState extends Equatable {
  const TruckListState([this.properties = const <dynamic>[]]);
  final List properties;
  @override
  List<Object> get props => properties as List<Object>;
}

class TrucklistLoading extends TruckListState {}

class TrucklistError extends TruckListState {
  final String message;

  TrucklistError(this.message) : super([message]);
}

class TrucklistShowing extends TruckListState {
  final List<Truck> trucks;
  final String? error;
  final String? success;

  TrucklistShowing(this.trucks, {this.error, this.success}) : super(trucks);
}
