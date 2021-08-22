import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';

abstract class TrackingRepository {
  Future<List<TrackingRoute>> getAll();
  Future<List<int>> getFree();
  Future<bool> delete(int id);
  Future<bool> assign(String id, int route);
}
