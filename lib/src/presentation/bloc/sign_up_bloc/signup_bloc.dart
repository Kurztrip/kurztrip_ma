import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupShowing());
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
      }
    }
  }
}
