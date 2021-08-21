//Type Truck de GraphQL
class Truck {
  const Truck({
    this.id,
    required this.registration,
    required this.status,
    required this.weight_capacity,
    required this.volume_capacity,
    required this.fuel_type,
    required this.fuel_capacity,
    required this.fuel_by_kilometer,
    required this.fuel,
    required this.warehouse,
  });

  final int? id;
  final String? registration;
  final String? status;
  final double? weight_capacity;
  final double? volume_capacity;
  final String? fuel_type;
  final double? fuel_capacity;
  final double? fuel_by_kilometer;
  final double? fuel;
  final int? warehouse;

  static Truck createEmpty() {
    return Truck(
        id: 0,
        registration: null,
        status: null,
        weight_capacity: null,
        volume_capacity: null,
        fuel_type: null,
        fuel_capacity: null,
        fuel_by_kilometer: null,
        fuel: null,
        warehouse: null);
  }
}
