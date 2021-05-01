part of 'package_list_bloc.dart';

abstract class PackageListState extends Equatable {
  const PackageListState();

  @override
  List<Object> get props => [];
}

class PackagelistLoading extends PackageListState {}

class PackagelistError extends PackageListState {
  final String message;

  PackagelistError(this.message);
}

class PackagelistShowing extends PackageListState {
  final List<Package> packages;

  PackagelistShowing(this.packages);
}
