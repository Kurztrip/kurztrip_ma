import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';

abstract class DBCenterFormEvent extends Equatable {
  const DBCenterFormEvent();

  @override
  List<Object> get props => [];
}

class UpdateAddress extends DBCenterFormEvent {
  final String address;
  const UpdateAddress(this.address);
}

class UpdateTotalStorage extends DBCenterFormEvent {
  final double storageSpace;
  const UpdateTotalStorage(this.storageSpace);
}

class UpdateAvailableStorage extends DBCenterFormEvent {
  final double storageSpace;
  const UpdateAvailableStorage(this.storageSpace);
}

class Submit extends DBCenterFormEvent {}

class DBCenterFormAutofill extends DBCenterFormEvent {
  final DistributionCenter dbcenter;

  DBCenterFormAutofill(this.dbcenter);
}
