import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/create_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/update_package_use_case.dart';

part 'packageform_event.dart';
part 'packageform_state.dart';

class PackageformBloc extends Bloc<PackageformEvent, PackageformState> {
  PackageformBloc() : super(PackageformShowing());
  CreatePackageUseCase createPackageUseCase = getIt();
  UpdatePackageUseCase updatePackageUseCase = getIt();
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
        id: event.id,
        address: event.address,
        receiver: event.receiver,
        receiverID: event.receiverID,
        weight: event.weight,
        volume: event.volume,
        warehouse: event.warehouse,
        update: true,
      );
    } else if (event is Submit) {
      PackageformShowing current = state as PackageformShowing;
      GoogleMapsGeocoding geo = GoogleMapsGeocoding(apiKey: mapsApiKey);
      GeocodingResponse response = await geo.searchByAddress(current.address);
      print(response.results[0].geometry.location.lat);
      print(response.results[0].geometry.location.lng);
      Package package = Package(
        id: current.id,
        address: current.address,
        receiver: current.receiver,
        idReceiver: current.receiverID,
        weight: current.weight,
        volume: current.volume,
        storeId: current.warehouse,
        longitude: response.results[0].geometry.location.lng,
        latitude: response.results[0].geometry.location.lat,
      );
      yield PackageformLoading();
      Either<Failure, Package> result =
          await createPackageUseCase(Params(package));
      yield* result.fold((failure) async* {
        yield current.copyWith(error: failure.error);
      }, (package) async* {
        yield PackageformSuccess();
      });
    }
  }
}
