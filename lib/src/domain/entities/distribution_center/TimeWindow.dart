import 'package:flutter/widgets.dart';

class TimeWindow {
  const TimeWindow(
      {@required this.id,
      @required this.beginning,
      @required this.ending,
      @required this.time_schedule_id});
  final int id;
  final String beginning;
  final String ending;
  final int time_schedule_id;

  static TimeWindow createEmpty() {
    return TimeWindow(
        id: 0,
        beginning: "00/00/0000",
        ending: "00/00/0000",
        time_schedule_id: 0);
  }
}
