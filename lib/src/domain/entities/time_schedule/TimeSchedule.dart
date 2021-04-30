import 'package:flutter/widgets.dart';

class TimeSchedule {
  const TimeSchedule({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.distribution_center_id,
  });
  final int id;
  final String title;
  final String description;
  final int distribution_center_id;

  static TimeSchedule createEmpty() {
    return TimeSchedule(
        id: 0,
        title: "desconocido",
        description: "desconocido",
        distribution_center_id: 0);
  }
}
//________________________________________________-
