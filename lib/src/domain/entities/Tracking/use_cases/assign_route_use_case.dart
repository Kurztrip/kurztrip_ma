import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/repositories/tracking_repository.dart';

class AssignRouteUseCase {
  final TrackingRepository _packageRepository = getIt();

  Future<Either<Failure, bool>> call(String id, int route) async {
    try {
      return Right(await _packageRepository.assign(id, route));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
