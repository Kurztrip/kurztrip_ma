import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/delete_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/get_packages_use_cases.dart';

part 'package_list_event.dart';
part 'package_list_state.dart';

class PackageListBloc extends Bloc<PackageListEvent, PackageListState> {
  final GetPackagesUseCase getPackagesUseCase = getIt();
  final DeletePackageUseCase deletePackageUseCase = getIt();
  PackageListBloc() : super(PackagelistLoading());

  @override
  Stream<PackageListState> mapEventToState(
    PackageListEvent event,
  ) async* {
    if (event is DeletePackage) {
      Either<Failure, bool> result = await deletePackageUseCase(event.id);
      yield* result.fold((failure) async* {
        yield PackagelistShowing([]);
      }, (package) async* {
        yield PackagelistShowing([]);
      });
    } else if (event is GetAllPackages) {
      yield* (await getPackagesUseCase()).fold((error) async* {
        yield PackagelistError(error.error);
      }, (packages) async* {
        yield PackagelistShowing(packages);
      });
    } else if (event is PackageListRefresh) {
      yield PackagelistLoading();
    } else {}
  }
}
