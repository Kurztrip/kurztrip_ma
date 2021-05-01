import 'package:kurztrip_ma/src/domain/entities/time_window/TimeWindow.dart';

abstract class TimeWindowRepository {
  Future<TimeWindow> get(int id);
  Future<List<TimeWindow>> getAll();
  Future<bool> save(TimeWindow time_window);
}
