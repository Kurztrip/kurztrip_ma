import 'package:kurztrip_ma/src/domain/entities/driver/Locations.dart';

abstract class LocationsRepository {
  Future<Locations> get(int id);
  Future<List<Locations>> getAll();
  Future<bool> add(Locations locations);
  Future<bool> update(int id, Locations locations);
  Future<bool> delete(int id); 

}