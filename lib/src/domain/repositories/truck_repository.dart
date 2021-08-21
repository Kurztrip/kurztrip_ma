import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';

abstract class TruckRepository {
  Future<Truck> get(int id);
  Future<List<Truck>> getAll();
  Future<Truck> add(Truck package);
  Future<int?> update(int? id, Truck package);
  Future<bool> delete(int id);
}
