import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/repositories/tracking_repository.dart';

class GetFreeRoutesUseCase {
  final TrackingRepository? repository = getIt();

  Future<Either<Failure, List<int>>> call() async {
    try {
      return Right(await repository!.getFree());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
