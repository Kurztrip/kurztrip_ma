import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainPageEvent extends Equatable {
  MainPageEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class TabSelected extends MainPageEvent {
  TabSelected({int index}) : super([index]);
}

class AddButtonPressed extends MainPageEvent {}
