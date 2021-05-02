import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/get_packages_use_cases.dart';

part 'package_list_event.dart';
part 'package_list_state.dart';

class PackageListBloc extends Bloc<PackageListEvent, PackageListState> {
  final GetPackagesUseCase getPackagesUseCase = getIt();

  PackageListBloc() : super(PackagelistLoading());

  @override
  Stream<PackageListState> mapEventToState(
    PackageListEvent event,
  ) async* {
    if (event is DeletePackage) {
    } else if (event is EditPackage) {
    } else if (event is GetAllPackages) {
      yield* (await getPackagesUseCase()).fold((error) async* {
        yield PackagelistError(error.error);
      }, (packages) async* {
        yield PackagelistShowing(packages);
      });
    } else if (event is PackageListRefresh) {
      yield PackagelistLoading();
    }
  }
}
