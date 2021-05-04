import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kurztrip_ma/services_provider.dart';
import 'package:kurztrip_ma/src/core/error/faliures.dart';
import 'package:kurztrip_ma/src/domain/entities/count/User.dart';
import 'package:kurztrip_ma/src/domain/entities/count/use_cases/create_user_use_case.dart';
import 'package:kurztrip_ma/src/domain/entities/count/use_cases/login_use_case.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupShowing());
  CreateUserUseCase createUserUseCase = getIt();
  LoginUseCase loginUseCase = getIt();
  List<String> roles = ['Administrador', 'Conductor'];
  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if(state is SignupShowing) {
      SignupShowing old = state as SignupShowing;
      if (event is UpdateCellphone) {
        yield old.copyWith(cellphone: event.cellphone);
      } else if (event is UpdateEmail) {
        yield old.copyWith(email: event.email);
      } else if (event is UpdateLastName) {
        yield old.copyWith(lastname: event.lastname);
      } else if (event is UpdateName) {
        yield old.copyWith(name: event.name);
      } else if (event is UpdatePassword) {
        yield old.copyWith(password: event.password);
      } else if (event is UpdateRol) {
        yield old.copyWith(rol: event.rol);
      } else if (event is UpdateUsername) {
        yield old.copyWith(username: event.username);
      } else if (event is Submit) {
        SignupShowing signUp = state as SignupShowing;
        print(signUp);
        User user = User(id: '', name: signUp.name, lastName: signUp.lastname, email: signUp.email, cellphone: signUp.cellphone, rol: signUp.rol, createAt: DateTime.now(), password: signUp.password, organization: '', notifications: []);
        Either<Failure, User> result =
        await createUserUseCase(Params(user));
        yield* result.fold((failure) async* {
          yield signUp.copyWith(error: failure.error);
        }, (user) async* {
          yield SignUpSuccess();
        });
      }
    }
  }
}
