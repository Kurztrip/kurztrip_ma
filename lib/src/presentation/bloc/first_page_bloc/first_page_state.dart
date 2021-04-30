import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FirstPageState extends Equatable {
  FirstPageState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class Showing extends FirstPageState {
  final int number;
  Showing({@required this.number}) : super([number]);
}
