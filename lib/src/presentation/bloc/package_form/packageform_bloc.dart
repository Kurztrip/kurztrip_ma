import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/create_package_use_case.dart';

part 'packageform_event.dart';
part 'packageform_state.dart';

class PackageformBloc extends Bloc<PackageformEvent, PackageformState> {
  PackageformBloc() : super(PackageformShowing());
  CreatePackageUseCase useCase=CreatePackageUseCase();
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
    }else if(event is Submit){
      PackageformShowing current=state as PackageformShowing;
      Package package =Package(
        address: current.address,
        receiver: current.receiver,
        idReceiver: current.receiverID,
        weight: current.weight,
        volume: current.volume,
        storeId: current.warehouse,
        longitude: null,
        latitude: null,
      );
      yield PackageformLoading();
      Either<Failure,Package> result =await useCase(Params(package));
      yield* result.fold(
          (failure)async*{
            yield current.copyWith(error:failure.error);
          },(package)async*{
            yield PackageformSuccess();
          }
      );
    }
  }
}