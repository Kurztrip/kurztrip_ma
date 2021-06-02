import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/repositories/distribution_center_repository.dart';

class DeleteDistributionCenterUseCase extends UseCase<bool, int> {
  final DistributionCenterRepository _distributionCenterRepository = getIt();

  @override
  Future<Either<Failure, bool>> call(int params) async {
    try {
      return Right(await _distributionCenterRepository.delete(params));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
