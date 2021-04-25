import 'package:flutter/widgets.dart';

class Truck {
  const Truck({
    @required this.id,
    @required this.warehouse,
  });
  final int id;
  final int warehouse;
  static Truck createEmpty() {
    return Truck(id: 0, warehouse: 0);
  }
}
