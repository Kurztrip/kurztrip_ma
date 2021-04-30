import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FirstPageEvent extends Equatable {
  FirstPageEvent([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class ButtonPressed extends FirstPageEvent {}
