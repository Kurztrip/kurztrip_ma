import 'package:flutter/widgets.dart';

class Route {
  const Route(
      {@required this.id,
      @required this.starting_time,
      @required this.p_longitudes,
      @required this.p_latitudes,
      @required this.driver_long,
      @required this.driver_lat});

  final int id;
  final double driver_long;
  final double driver_lat;
  final String starting_time;
  final List<double> p_longitudes;
  final List<double> p_latitudes;

  static Route createEmpty() {
    return Route(
        id: 0,
        starting_time: null,
        p_longitudes: null,
        p_latitudes: null,
        driver_long: null,
        driver_lat: null);
  }
}
