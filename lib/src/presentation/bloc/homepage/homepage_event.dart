import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  HomepageEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class SignInButtonPressed extends HomepageEvent {}
class SignIn extends HomepageEvent {}
class BackToHome extends HomepageEvent {}