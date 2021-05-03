import 'package:equatable/equatable.dart';

abstract class EditAccountState extends Equatable {
  const EditAccountState([this.properties = const <dynamic>[]]) : super();
  final List properties;
  @override
  List<Object> get props => properties;
}

class EditShowing extends EditAccountState {
  final String name;
  final String lastname;
  final String cellphone;
  final String email;

  EditShowing({
    this.name,
    this.lastname,
    this.cellphone,
    this.email,
  }) : super([name, lastname, cellphone, email]);
  EditShowing copyWith({
    String name,
    String lastname,
    String cellphone,
    String email,
  }) {
    return EditShowing(
      name: name == null ? this.name : name,
      lastname: lastname == null ? this.lastname : lastname,
      cellphone: cellphone == null ? this.cellphone : cellphone,
      email: email == null ? this.email : email,
    );
  }
}
