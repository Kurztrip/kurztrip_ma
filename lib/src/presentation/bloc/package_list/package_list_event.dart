part of 'package_list_bloc.dart';

abstract class PackageListEvent extends Equatable {
  const PackageListEvent();

  @override
  List<Object> get props => [];
}

class EditPackage extends PackageListEvent {
  const EditPackage(this.id);
  final int id;
  @override
  List<Object> get props => [];
}

class DeletePackage extends PackageListEvent {
  const DeletePackage(this.id);
  final int id;

  @override
  List<Object> get props => [];
}

class GetAllPackages extends PackageListEvent {
  const GetAllPackages();

  @override
  List<Object> get props => [];
}
