import 'package:equatable/equatable.dart';

abstract class DBCenterFormState extends Equatable {
  const DBCenterFormState([this.properties = const <dynamic>[]]) : super();
  final List properties;
  @override
  List<Object> get props => [properties];
}

class DBCenterFormLoading extends DBCenterFormState {}

class DBCenterFormSuccess extends DBCenterFormState {}

class DBCenterFormShowing extends DBCenterFormState {
  final int? id;
  final String? error;
  final String? address;
  final double? totalStorage;
  final double? availableStorage;
  final bool? update;

  DBCenterFormShowing({
    this.id,
    this.error,
    this.address,
    this.totalStorage,
    this.availableStorage,
    this.update,
  }) : super([
          id,
          error,
          address,
          totalStorage,
          availableStorage,
        ]);
  DBCenterFormShowing copyWith({
    String? address,
    double? totalStorage,
    double? availableStorage,
    String? error,
  }) {
    return DBCenterFormShowing(
        id: this.id,
        address: address != null ? address : this.address,
        totalStorage: totalStorage != null ? totalStorage : this.totalStorage,
        availableStorage:
            availableStorage != null ? availableStorage : this.availableStorage,
        update: this.update,
        error: error != null ? error : null);
  }
}
