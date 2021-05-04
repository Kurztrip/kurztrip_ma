part of 'packageform_bloc.dart';

abstract class PackageformEvent extends Equatable {
  const PackageformEvent();

  @override
  List<Object> get props => [];
}

class UpdateAddress extends PackageformEvent {
  final String address;
  const UpdateAddress(this.address);
}

class Submit extends PackageformEvent {}

class UpdateReceiver extends PackageformEvent {
  final String receiver;
  const UpdateReceiver(this.receiver);
}

class UpdateReceiverId extends PackageformEvent {
  final String receiverId;
  UpdateReceiverId(this.receiverId);
}

class UpdateWeight extends PackageformEvent {
  final double weight;
  UpdateWeight(this.weight);
}

class UpdateVolume extends PackageformEvent {
  final double volume;
  UpdateVolume(this.volume);
}

class UpdateWarehouse extends PackageformEvent {
  final int warehouse;
  UpdateWarehouse(this.warehouse);
}

class GetPackageAutofill extends PackageformEvent {}

class DeletePackage extends PackageformEvent {
  final int id;

  DeletePackage(this.id);
}

class ToPackageError extends PackageformEvent {
  final String error;

  ToPackageError(this.error);
}

class PackageFormAutofill extends PackageformEvent {
  final int id;
  final String address;
  final String receiver;
  final String receiverID;
  final double weight;
  final double volume;
  final int warehouse;

  PackageFormAutofill(this.id, this.address, this.receiver, this.receiverID,
      this.weight, this.volume, this.warehouse);
}
