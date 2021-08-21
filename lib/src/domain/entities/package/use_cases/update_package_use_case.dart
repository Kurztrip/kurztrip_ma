import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/repositories/package_repository.dart';

class UpdatePackageUseCase extends UseCase<Package, UpdateParams> {
  final PackageRepository? _packageRepository = getIt();

  @override
  Future<Either<Failure, Package>> call(UpdateParams params) async {
    try {
      return Right(
          await _packageRepository!.update(params.package.id, params.package));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class UpdateParams {
  final Package package;

  UpdateParams(this.package);
}
