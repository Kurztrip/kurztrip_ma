import 'package:dartz/dartz.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/core/usecases/usecases.dart';
import 'package:kurztrip_ma/src/domain/repositories/user_repository.dart';

class LoginUseCase extends UseCase<String, LoginParams>{
  final UserRepository? _userRepository = getIt();

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    try {
      return Right(
          await _userRepository!.login(params.email, params.password));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

class LoginParams{
  final String? email;
  final String? password;
  LoginParams(this.email, this.password);
}