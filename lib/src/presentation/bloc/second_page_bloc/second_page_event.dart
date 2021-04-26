import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SecondPageEvent extends Equatable {
  SecondPageEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class TabSelected extends SecondPageEvent {
  TabSelected({int index}) : super([index]);
}
