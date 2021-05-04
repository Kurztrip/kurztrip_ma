import 'package:get_it/get_it.dart';
import 'package:kurztrip_ma/src/data/count/user_server_repository.dart';
import 'package:kurztrip_ma/src/data/driver/driver_server_repository.dart';
import 'package:kurztrip_ma/src/data/truck/truck_server_repository.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/delete_route_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/use_cases/get_routes_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/domain/entities/count/use_cases/create_user_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/count/use_cases/login_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/create_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/delete_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/get_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/get_packages_use_cases.dart';
import 'package:kurztrip_ma/src/domain/entities/package/use_cases/update_package_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/create_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/delete_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/get_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/get_trucks_use_cases.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/use_cases/update_truck_use_case.dart';
import 'package:kurztrip_ma/src/domain/repositories/locations_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';
import 'package:kurztrip_ma/src/data/package/package_server_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/package_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/user_repository.dart';
import 'package:kurztrip_ma/src/presentation/bloc/db_center_form_bloc/db_center_form_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/edit_account_bloc/edit_account_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_form/packageform_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/package_list/package_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/routes_list_bloc/routes_list_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/sign_up_bloc/signup_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/truck_form/truckform_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/truck_list_bloc/truck_list_bloc.dart';

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
  getIt.registerFactoryParam<TruckformBloc, int, void>(
      (param1, param2) => TruckformBloc(edit: param1));
  getIt.registerFactoryParam<PackageformBloc, int, void>(
      (param1, param2) => PackageformBloc(edit: param1));
  getIt.registerFactory(
    () => DBCenterFormBloc(),
  );
  getIt.registerFactory(
    () => PackageListBloc(),
  );
  getIt.registerFactory(
    () => TruckListBloc(),
  );
  getIt.registerFactory(
    () => RoutesListBloc(),
  );
  getIt.registerFactoryParam<EditAccountBloc, User, void>(
      (param1, param2) => EditAccountBloc(param1));
  //Repositories
  getIt.registerLazySingleton<TruckRepository>(() => TruckServerRepository());
  getIt.registerLazySingleton<PackageRepository>(
      () => PackageServerRepository());
  getIt.registerLazySingleton<UserRepository>(() => UserServerRepository());
  //Usecases
  getIt.registerSingleton(GetPackageUseCase());
  getIt.registerSingleton(GetPackagesUseCase());
  getIt.registerSingleton(CreateUserUseCase());
  getIt.registerSingleton(LoginUseCase());
  getIt.registerSingleton(CreatePackageUseCase());
  getIt.registerSingleton(UpdatePackageUseCase());
  getIt.registerSingleton(DeletePackageUseCase());
  getIt.registerSingleton(GetTruckUseCase());
  getIt.registerSingleton(GetTrucksUseCase());
  getIt.registerSingleton(CreateTruckUseCase());
  getIt.registerSingleton(UpdateTruckUseCase());
  getIt.registerSingleton(DeleteTruckUseCase());
  getIt.registerSingleton(GetRoutesUseCase());
  getIt.registerSingleton(DeleteRouteUseCase());
  getIt.registerLazySingleton<LocationsRepository>(
      () => DriverServerRepository());
}
