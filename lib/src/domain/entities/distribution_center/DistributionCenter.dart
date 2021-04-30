import 'package:flutter/widgets.dart';

class DistributionCenter {
  const DistributionCenter({
    @required this.id,
    @required this.address,
    @required this.latitude_location,
    @required this.longitude_location,
    @required this.total_space,
    @required this.available_space,
  });
  final int id;
  final String address;
  final double latitude_location;
  final double longitude_location;
  final double total_space;
  final double available_space;

  static DistributionCenter createEmpty() {
    return DistributionCenter(
        id: 0,
        address: "desconocido",
        latitude_location: 0.0,
        longitude_location: 0.0,
        total_space: 0.0,
        available_space: 0.0);
  }
}
