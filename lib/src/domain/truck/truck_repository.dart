import 'package:kurztrip_ma/src/domain/truck/Truck.dart';

abstract class TruckRepository {
  Future<Truck> get(int id);
  Future<List<Truck>> getAll();
  Future<bool> save(Truck truck);
}
