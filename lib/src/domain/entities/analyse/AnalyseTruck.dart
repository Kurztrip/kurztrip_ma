import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';

//Type Truck de GraphQL
class AnalyseTruck {
  const AnalyseTruck(
      {required this.id,
      required this.packages,
      required this.route,
      required this.weight_capacity,
      required this.volume_capacity,
      required this.fuel_type,
      required this.fuel_capacity,
      required this.fuel_by_kilometer,
      required this.fuel,
      required this.state, //state o status?
      required this.warehouse});

  final int id;
  final List<Package>? packages;
  final List<List<double>>? route;
  final String? state;
  final double? weight_capacity;
  final double? volume_capacity;
  final String? fuel_type;
  final double? fuel_capacity;
  final double? fuel_by_kilometer;
  final double? fuel;
  final int? warehouse;

  static AnalyseTruck createEmpty() {
    return AnalyseTruck(
        id: 0,
        packages: null,
        route: null,
        state: null,
        weight_capacity: null,
        volume_capacity: null,
        fuel_type: null,
        fuel_capacity: null,
        fuel_by_kilometer: null,
        fuel: null,
        warehouse: null);
  }
}
