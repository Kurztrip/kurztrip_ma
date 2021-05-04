import 'package:flutter/widgets.dart';

class TrackingRoute {
  const TrackingRoute(
      {this.truck_id, this.starting_time, this.p_longitudes, this.p_latitudes, this.driver_long, this.driver_lat});

  final int truck_id; //id
  final double driver_long;
  final double driver_lat;
  final String starting_time;
  final List<double> p_longitudes;
  final List<double> p_latitudes;

  static TrackingRoute createEmpty() {
    return TrackingRoute(
        truck_id: 0, starting_time: null, p_longitudes: null, p_latitudes: null, driver_long: null, driver_lat: null);
  }
}
