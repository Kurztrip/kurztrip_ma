import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';

abstract class TrackingRepository {
  Future<List<TrackingRoute>> getAll();
  Future<bool> delete(int id);
}
