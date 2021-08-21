import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';

abstract class PackageRepository {
  Future<Package> get(int id);
  Future<List<Package>?> getAll();
  Future<Package> add(Package package);
  Future<Package> update(int? id, Package package);
  Future<bool> delete(int id);
}