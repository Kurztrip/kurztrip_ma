part of 'package_list_bloc.dart';

abstract class PackageListState extends Equatable {
  const PackageListState([this.properties = const <dynamic>[]]);
  final List properties;
  @override
  List<Object> get props => properties as List<Object>;
}

class PackagelistLoading extends PackageListState {}

class PackagelistError extends PackageListState {
  final String message;

  PackagelistError(this.message) : super([message]);
}

class PackagelistShowing extends PackageListState {
  final List<Package> packages;
  final String? error;
  final String? success;

  PackagelistShowing(this.packages, {this.error, this.success})
      : super(packages);
}
