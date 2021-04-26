import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SecondPageState extends Equatable {
  SecondPageState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class Showing extends SecondPageState {
  final int index;
  Showing({@required this.index}) : super([index]);
}
