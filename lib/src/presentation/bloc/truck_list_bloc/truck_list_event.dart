part of 'truck_list_bloc.dart';

abstract class TruckListEvent extends Equatable {
  const TruckListEvent();

  @override
  List<Object> get props => [];
}

class GetAllTrucks extends TruckListEvent {
  const GetAllTrucks();
}

class DeleteTruck extends TruckListEvent {
  const DeleteTruck(this.id);
  final int id;
}

class EditTruck extends TruckListEvent {
  const EditTruck(this.id);
  final int id;
  @override
  List<Object> get props => [];
}

class TruckListRefresh extends TruckListEvent {
  const TruckListRefresh();

  @override
  List<Object> get props => [];
}
