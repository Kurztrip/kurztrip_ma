import 'package:kurztrip_ma/src/domain/entities/distribution_center/TimeSchedule.dart';

abstract class TimeScheduleRepository {
  Future<TimeSchedule> get(int id);
  Future<List<TimeSchedule>> getAll();
  Future<bool> save(TimeSchedule time_schdule);
}
