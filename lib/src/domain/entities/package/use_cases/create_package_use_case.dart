import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/package/Package.dart';
import 'package:kurztrip_ma/src/domain/repositories/package_repository.dart';



class CreatePackageUseCase extends UseCase<Package,Params>{
  final PackageRepository _packageRepository=getIt();

  @override
  Future<Either<Failure,Package>> call(Params params) async{
    try {
      return Right(await _packageRepository.add(params.package));
    }catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }
}
class Params {
  final Package package;

  Params(this.package);
}