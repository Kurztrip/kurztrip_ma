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
  // String user;
  // String password;

  SignInState():super([]);
}
class SignUpState extends HomepageState {
  SignUpState() : super([]);
}
class Home extends HomepageState{}
