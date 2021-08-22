class TrackingPackage {
  const TrackingPackage(
      {required this.id,
      required this.id_truck,
      required this.destination_long,
      required this.destination_lat,
      required this.state,
      required this.estimated_time});

  final int id;
  final int? id_truck;
  final double destination_long;
  final double? destination_lat;
  final String? state;
  final String? estimated_time;

  static TrackingPackage createEmpty() {
    return TrackingPackage(
        id: 0,
        id_truck: null,
        destination_long: 0,
        destination_lat: null,
        state: null,
        estimated_time: null);
  }
}
