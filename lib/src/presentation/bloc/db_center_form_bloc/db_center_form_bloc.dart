import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/use_cases/create_distribution_center_use_case.dart';
import 'package:kurztrip_ma/src/presentation/bloc/db_center_form_bloc/db_center_form_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/db_center_form_bloc/db_center_form_state.dart';

class DBCenterFormBloc extends Bloc<DBCenterFormEvent, DBCenterFormState> {
  DBCenterFormBloc() : super(DBCenterFormShowing());
  CreateDistributionCenterUseCase useCase = getIt();
  @override
  Stream<DBCenterFormState> mapEventToState(
    DBCenterFormEvent event,
  ) async* {
    if (event is UpdateAddress) {
      yield (state as DBCenterFormShowing).copyWith(address: event.address);
    } else if (event is UpdateTotalStorage) {
      yield (state as DBCenterFormShowing)
          .copyWith(totalStorage: event.storageSpace);
    } else if (event is UpdateAvailableStorage) {
      yield (state as DBCenterFormShowing)
          .copyWith(availableStorage: event.storageSpace);
    } else if (event is DBCenterFormAutofill) {
      yield DBCenterFormShowing(
        id: event.dbcenter.id,
        address: event.dbcenter.address,
        totalStorage: event.dbcenter.total_space,
        availableStorage: event.dbcenter.available_space,
        update: true,
      );
    } else if (event is Submit) {
      DBCenterFormShowing current = state as DBCenterFormShowing;
      GoogleMapsGeocoding geo = GoogleMapsGeocoding(apiKey: mapsApiKey);
      GeocodingResponse response = await geo.searchByAddress(current.address);
      print(response.results[0].geometry.location.lat);
      print(response.results[0].geometry.location.lng);
      DistributionCenter dbCenter = DistributionCenter(
        id: current.id,
        address: current.address,
        total_space: current.totalStorage,
        available_space: current.availableStorage,
        longitude_location: response.results[0].geometry.location.lng,
        latitude_location: response.results[0].geometry.location.lat,
      );
      print('Distribution Center latitude: ${dbCenter.latitude_location}');
      print('Distribution Center longitude: ${dbCenter.longitude_location}');
      yield DBCenterFormLoading();
      //llamar metodo de caso de uso
      Either<Failure, DistributionCenter> result =
          await useCase(Params(dbCenter));
      yield* result.fold((failure) async* {
        yield current.copyWith(
            error: "operación fallida, por favor revisa tu conexión");
      }, (package) async* {
        yield DBCenterFormSuccess();
      });
    }
  }
}
