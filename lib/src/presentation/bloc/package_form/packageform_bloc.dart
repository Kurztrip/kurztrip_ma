import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'packageform_event.dart';
part 'packageform_state.dart';

class PackageformBloc extends Bloc<PackageformEvent, PackageformState> {
  PackageformBloc() : super(PackageformShowing());

  @override
  Stream<PackageformState> mapEventToState(
    PackageformEvent event,
  ) async* {
    if (event is UpdateAddress) {
      yield (state as PackageformShowing).copyWith(address: event.address);
    } else if (event is UpdateReceiver) {
      yield (state as PackageformShowing).copyWith(receiver: event.receiver);
    } else if (event is UpdateReceiverId) {
      yield (state as PackageformShowing)
          .copyWith(receiverID: event.receiverId);
    } else if (event is UpdateVolume) {
      yield (state as PackageformShowing).copyWith(volume: event.volume);
    } else if (event is UpdateWarehouse) {
      yield (state as PackageformShowing).copyWith(warehouse: event.warehouse);
    } else if (event is UpdateWeight) {
      yield (state as PackageformShowing).copyWith(weight: event.weight);
    } else if (event is PackageFormAutofill) {
      yield PackageformShowing(
        address: event.address,
        receiver: event.receiver,
        receiverID: event.receiverID,
        weight: event.weight,
        volume: event.volume,
        warehouse: event.warehouse,
        update: true,
      );
    }
  }
}
