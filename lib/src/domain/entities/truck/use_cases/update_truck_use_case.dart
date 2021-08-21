import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

class UpdateTruckUseCase extends UseCase<int?, UpdateParams> {
  final TruckRepository? _truckRepository = getIt();

  @override
  Future<Either<Failure, int?>> call(UpdateParams params) async {
    try {
      return Right(
          await _truckRepository!.update(params.truck.id, params.truck));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class UpdateParams {
  final Truck truck;

  UpdateParams(this.truck);
}
