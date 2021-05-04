import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';

abstract class TrackingRepository {
  Future<Truck> get(int id);
  Future<List<Route>> getAll();
  Future<bool> save(Truck truck);

  Future<List<Package>> getTrackingPackages();
  String getPackageState(int id);
  String getPackageETA(id);
  createTrackingPackage(Package new_package);
  updatePackageState(int id, String state);
  deleteTrackingPackage(id);

  Future<Route> getRoute(id);
  createRoute(Route new_route);
  updateRoute(int id, Route route);
  deleteRoute(int id);
}
