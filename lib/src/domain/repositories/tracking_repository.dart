import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';

abstract class TrackingRepository {
  Future<List<TrackingRoute>> getAll();
}
