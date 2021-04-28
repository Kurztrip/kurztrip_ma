import 'package:get_it/get_it.dart';
import 'package:kurztrip_ma/src/data/truck/truck_server_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';
import 'package:kurztrip_ma/src/presentation/bloc/first_page_bloc/first_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/second_page_bloc/second_page_bloc.dart';
import 'package:kurztrip_ma/src/presentation/bloc/sign_up_bloc/signup_bloc.dart';

final getIt = GetIt.instance;

void init() {
  registerUserService();
}

void registerUserService() {
  //Blocs
  getIt.registerFactory(
    () => FirstPageBloc(),
  );
  getIt.registerFactory(
    () => SecondPageBloc(),
  );
  getIt.registerFactory(
    () => HomepageBloc(),
  );
  getIt.registerFactory(
    () => SignupBloc(),
  );
  //Repositories
  getIt.registerLazySingleton<TruckRepository>(() => TruckServerRepository());
}
