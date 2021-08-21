import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/domain/entities/distribution_center/DistributionCenter.dart';
import 'package:kurztrip_ma/src/domain/repositories/distribution_center_repository.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

class GetDistributionCentersUseCase {
  final DistributionCenterRepository _distributionCenterRepository = getIt();
  Future<Either<Failure, List<DistributionCenter>>> call() async {
    try {
      return Right(await _distributionCenterRepository.getAll());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
