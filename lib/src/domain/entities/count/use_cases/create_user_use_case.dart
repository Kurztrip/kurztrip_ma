import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/domain/repositories/user_repository.dart';

class CreateUserUseCase extends UseCase<User,Params>{
 final UserRepository _userRepository = getIt();
 @override
 Future<Either<Failure,User>> call(Params params) async{
   try {
     return Right(await _userRepository.add(params.user));
   }catch(e){
     return Left(ServerFailure(e.toString()));
   }
 }
}

class Params{
  final User user;
  Params(this.user);
}