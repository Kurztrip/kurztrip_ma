import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/count/use_cases/create_user_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/count/use_cases/login_use_case.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_event.dart';
import 'package:kurztrip_ma/src/presentation/bloc/homepage/homepage_state.dart';

import '../../../domain/entities/count/User.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  LoginUseCase? loginUseCase = getIt();
  HomepageBloc() : super(Home());

  @override
  Stream<HomepageState> mapEventToState(HomepageEvent event) async* {
    if (event is SignInButtonPressed) {
      yield SignInState();
    } else if (event is BackToHome) {
      yield Home();
    } else if (event is UpdateUser) {
      yield (state as SignInState).copyWith(user: event.user);
    } else if (event is UpdatePassword) {
      yield (state as SignInState).copyWith(password: event.password);
    } else if(event is SignIn){
      SignInState signIn = state as SignInState;
      Either<Failure, String> result =
        await loginUseCase!(LoginParams(signIn.user, signIn.password));
      yield* result.fold((failure) async* {
          yield signIn.copyWith(error: failure.error);
        }, (login) async* {
          yield LoginDone();
        });
    }
  }
}
