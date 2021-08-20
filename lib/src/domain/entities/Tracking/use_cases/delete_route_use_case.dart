import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/repositories/tracking_repository.dart';

class DeleteRouteUseCase extends UseCase<bool, int> {
  final TrackingRepository? _packageRepository = getIt();

  @override
  Future<Either<Failure, bool>> call(int params) async {
    // try {
    //   return Right(await _packageRepository.deleteRoute(params));
    // } catch (e) {
    //   return Left(ServerFailure(e.toString()));
    // }
    return Left(ServerFailure(" "));
  }
}
