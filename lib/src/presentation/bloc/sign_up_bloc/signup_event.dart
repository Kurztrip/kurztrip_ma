part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class UpdateName extends SignupEvent {
  final String name;
  UpdateName(this.name);
}

class UpdateLastName extends SignupEvent {
  final String lastname;
  UpdateLastName(this.lastname);
}

class UpdateCellphone extends SignupEvent {
  final String cellphone;
  UpdateCellphone(this.cellphone);
}

class UpdateRol extends SignupEvent {
  final String rol;
  UpdateRol(this.rol);
}

class UpdatePassword extends SignupEvent {
  final String password;
  UpdatePassword(this.password);
}

class UpdateEmail extends SignupEvent {
  final String email;
  UpdateEmail(this.email);
}

class UpdateUsername extends SignupEvent {
  final String username;
  UpdateUsername(this.username);
}
