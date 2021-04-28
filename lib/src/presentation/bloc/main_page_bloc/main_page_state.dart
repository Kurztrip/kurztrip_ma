import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainPageState extends Equatable {
  MainPageState([this.properties = const <dynamic>[]]) : super();

  final List properties;

  @override
  List<Object> get props => properties;
}

class PackageTab extends MainPageState {
  final List<String> packageList;
  PackageTab({@required this.packageList}) : super(packageList);
}

class Showing extends MainPageState {
  final int index;
  Showing({@required this.index}) : super([index]);
}
