import 'package:flutter/widgets.dart';

class Truck {
  const Truck({@required this.id});
  final int id;
  static Truck createEmpty() {
    return Truck(id: 0);
  }
}
