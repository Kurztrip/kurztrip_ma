import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';

abstract class DistributionCenterRepository {
  Future<DistributionCenter> get(int id);
  Future<List<DistributionCenter>> getAll();
  Future<bool> save(DistributionCenter distribution_center);
}
