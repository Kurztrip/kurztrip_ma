import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/Tracking/Route.dart';
import 'package:kurztrip_ma/src/domain/repositories/analyse_repository.dart';

class CreatePackageUseCase extends UseCase<bool, int> {
  final AnalyseRepository? _analyseRepository = getIt();

  @override
  Future<Either<Failure, bool>> call(int id) async {
    try {
      return Right(await _analyseRepository!.createAnalyseRoute(id));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
