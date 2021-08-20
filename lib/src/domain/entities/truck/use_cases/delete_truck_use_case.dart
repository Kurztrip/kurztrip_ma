import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

class DeleteTruckUseCase extends UseCase<bool, int> {
  final TruckRepository? _truckRepository = getIt();

  @override
  Future<Either<Failure, bool>> call(int params) async {
    try {
      return Right(await _truckRepository!.delete(params));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
