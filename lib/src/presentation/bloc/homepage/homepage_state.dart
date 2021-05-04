import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageState extends Equatable {
  HomepageState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class LoginDone extends HomepageState{}

class SignInState extends HomepageState {
  final String user;
  final String password;
  final String error;
  SignInState({this.user, this.password, this.error}) : super([user, password, error]);
  SignInState copyWith({String user, String password, String error}) {
    return SignInState(
        user: user != null ? user : this.user,
        password: password != null ? password : this.password,
        error: error != null ? error : null);

  }
}

class Home extends HomepageState {
  final String home;

  Home({this.home = "home"}) : super([home]);
}
