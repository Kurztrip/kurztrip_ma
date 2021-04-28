import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageState extends Equatable {
  HomepageState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class SignInState extends HomepageState {
  final String user;
  final String password;

  SignInState({this.user, this.password}) : super([user, password]);
  SignInState copyWith({String user, String password}) {
    return SignInState(
        user: user != null ? user : this.user,
        password: password != null ? password : this.password);
  }
}

class Home extends HomepageState {
  final String home;

  Home({this.home = "home"}) : super([home]);
}
