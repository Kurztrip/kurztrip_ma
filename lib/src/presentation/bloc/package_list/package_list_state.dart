part of 'package_list_bloc.dart';

abstract class PackageListState extends Equatable {
  const PackageListState([this.properties = const <dynamic>[]]);
  final List properties;
  @override
  List<Object> get props => properties;
}

class PackagelistLoading extends PackageListState {}

class PackagelistError extends PackageListState {
  final String message;

  PackagelistError(this.message) : super([message]);
}

class PackagelistShowing extends PackageListState {
  final List<Package> packages;

  PackagelistShowing(this.packages) : super(packages);
}
