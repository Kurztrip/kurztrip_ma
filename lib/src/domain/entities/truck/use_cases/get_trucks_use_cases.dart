import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/truck/Truck.dart';
import 'package:kurztrip_ma/src/domain/repositories/truck_repository.dart';

class GetTrucksUseCase {
  Future<Either<Failure, List<Truck>>> call() async {
    TruckRepository _truckRepository = getIt();
    try {
      return Right(await _truckRepository.getAll());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
