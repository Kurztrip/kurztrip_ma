import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  HomepageEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties as List<Object>;
}

class SignInButtonPressed extends HomepageEvent {}

class SignIn extends HomepageEvent {}

class BackToHome extends HomepageEvent {}

class UpdateUser extends HomepageEvent {
  final String user;
  UpdateUser(this.user);
}

class UpdatePassword extends HomepageEvent {
  final String password;
  UpdatePassword(this.password);
}
