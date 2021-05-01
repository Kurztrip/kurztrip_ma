import 'package:flutter/widgets.dart';

class Locations{
  const Locations({
    @required this.id,
    @required this.truckId,
    @required this.latitude,
    @required this.longitude
  });
  final int id;
  final int truckId;
  final double latitude;
  final double longitude;

  static Locations createEmpty(){
    return Locations(id: 0, truckId: 0, latitude: 0, longitude: 0);
  }
}