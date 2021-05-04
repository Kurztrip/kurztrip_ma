import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/repositories/tracking_repository.dart';

class GetRoutesUseCase {
  final TrackingRepository repository = getIt();

  Future<Either<Failure, List<TrackingRoute>>> call() async {
    try {
      return Right(await repository.getAll());
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}
