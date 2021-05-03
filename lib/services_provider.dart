import 'package:get_it/get_it.dart';
import 'package:kurztrip_ma/src/data/count/user_server_repository.dart';
import 'package:kurztrip_ma/src/data/driver/driver_server_repository.dart';
import 'package:kurztrip_ma/src/data/truck/truck_server_repository.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/create_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/delete_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/get_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/get_packages_use_cases.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/update_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/repositories/locations_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';
import 'package:kurztrip_ma/src/data/package/package_server_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/package_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/user_repository.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_form/packageform_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_list/package_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/sign_up_bloc/signup_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/truck_form/truckform_bloc.dart';

final getIt = GetIt.instance;
final String mapsApiKey = "AIzaSyAFCcyGgadxT2LaaQjcTRl0cGhPQSY9lBk";

void init() {
  registerUserService();
}

void registerUserService() {
  //Blocs
  getIt.registerFactory(
    () => HomepageBloc(),
  );
  getIt.registerFactory(
    () => SignupBloc(),
  );
  getIt.registerFactory(
    () => MainPageBloc(),
  );
  getIt.registerFactory(
    () => TruckformBloc(),
  );
  getIt.registerFactoryParam<PackageformBloc, int, void>(
      (param1, param2) => PackageformBloc(edit: param1));
  getIt.registerFactory(
    () => PackageListBloc(),
  );
  getIt.registerFactoryParam<EditAccountBloc, User, void>(
      (param1, param2) => EditAccountBloc(param1));
  //Repositories
  getIt.registerLazySingleton<TruckRepository>(() => TruckServerRepository());
  getIt.registerLazySingleton<PackageRepository>(
      () => PackageServerRepository());
  //Usecases
  getIt.registerSingleton(GetPackageUseCase());
  getIt.registerSingleton(GetPackagesUseCase());
  getIt.registerSingleton(CreatePackageUseCase());
  getIt.registerSingleton(UpdatePackageUseCase());
  getIt.registerSingleton(DeletePackageUseCase());
  getIt.registerLazySingleton<LocationsRepository>(
      () => DriverServerRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserServerRepository());
}
