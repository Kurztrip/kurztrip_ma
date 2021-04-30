part of 'packageform_bloc.dart';

abstract class PackageformState extends Equatable {
  const PackageformState([this.properties = const <dynamic>[]]) : super();
  final List properties;
  @override
  List<Object> get props => [properties];
}

class PackageformShowing extends PackageformState {
  final String address;
  final String receiver;
  final String receiverID;
  final double weight;
  final double volume;
  final int warehouse;
  final bool update;

  PackageformShowing({
    this.address,
    this.receiver,
    this.receiverID,
    this.weight,
    this.volume,
    this.warehouse,
    this.update,
  }) : super([address, receiver, receiverID, weight, volume, warehouse]);
  PackageformShowing copyWith({
    String address,
    String receiver,
    String receiverID,
    double weight,
    double volume,
    int warehouse,
  }) {
    return PackageformShowing(
      address: address != null ? address : this.address,
      receiver: receiver != null ? receiver : this.receiver,
      receiverID: receiverID != null ? receiverID : this.receiverID,
      weight: weight != null ? weight : this.weight,
      volume: volume != null ? volume : this.volume,
      warehouse: warehouse != null ? warehouse : this.warehouse,
      update: this.update,
    );
  }
}
