import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/domain/repositories/distribution_center_repository.dart';

class CreateDistributionCenterUseCase
    extends UseCase<DistributionCenter, Params> {
  final DistributionCenterRepository _distributionCenterRepository = getIt();

  @override
  Future<Either<Failure, DistributionCenter>> call(Params params) async {
    try {
      return Right(
          await _distributionCenterRepository.add(params.distributionCenter));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class Params {
  final DistributionCenter distributionCenter;

  Params(this.distributionCenter);
}
