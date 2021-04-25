import 'package:get_it/get_it.dart';
import 'package:kurztrip_ma/src/data/truck/truck_server_repository.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

final getIt = GetIt.instance;

void init() {
  registerUserService();
}

void registerUserService() {
  getIt.registerLazySingleton<TruckRepository>(() => TruckServerRepository());
}
