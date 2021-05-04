import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

class CreateTruckUseCase extends UseCase<Truck, Params> {
  final TruckRepository _truckRepository = getIt();

  @override
  Future<Either<Failure, Truck>> call(Params params) async {
    try {
      return Right(await _truckRepository.add(params.truck));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class Params {
  final Truck truck;

  Params(this.truck);
}
