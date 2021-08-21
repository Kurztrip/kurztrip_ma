import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/repositories/package_repository.dart';

class GetPackagesUseCase {
  Future<Either<Failure, List<Package>?>> call() async {
    PackageRepository _packageRepository = getIt();
    try {
      return Right(await _packageRepository.getAll());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
