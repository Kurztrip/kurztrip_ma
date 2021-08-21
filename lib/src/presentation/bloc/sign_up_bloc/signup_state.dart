part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState([this.properties = const <dynamic>[]]) : super();
  final List properties;
  @override
  List<Object?> get props => properties;
}

class SignUpLoading extends SignupState{}

class SignUpSuccess extends SignupState{}

class SignupShowing extends SignupState {
  final String? error;
  final String? name;
  final String? lastname;
  final String? username;
  final String? password;
  final String? cellphone;
  final String? email;
  final String? rol;

  SignupShowing({
    this.error,
    this.name,
    this.lastname,
    this.username,
    this.password,
    this.cellphone,
    this.email,
    this.rol,
  }) : super([name,lastname,cellphone,username,password,email,rol]);
  SignupShowing copyWith(
      {String? name,
        String? error,
      String? lastname,
      String? username,
      String? password,
      String? cellphone,
      String? email,
      String? rol}) {
    return SignupShowing(
        name: name == null ? this.name : name,
        lastname: lastname == null ? this.lastname : lastname,
        username: username == null ? this.username : username,
        password: password == null ? this.password : password,
        cellphone: cellphone == null ? this.cellphone : cellphone,
        email: email == null ? this.email : email,
        rol: rol == null ? this.rol : rol,
        error: error != null ? error: null);
  }
}
