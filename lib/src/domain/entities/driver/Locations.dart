import 'package:flutter/widgets.dart';

class Locations {
  const Locations({required this.id, this.truck_id, required this.latitude, required this.longitude});
  final int id;
  final int? truck_id;
  final double latitude;
  final double longitude;

  static Locations createEmpty() {
    return Locations(id: 0, truck_id: 0, latitude: 0, longitude: 0);
  }
}
