import 'package:equatable/equatable.dart';

abstract class EditAccountEvent extends Equatable {
  const EditAccountEvent();

  @override
  List<Object> get props => [];
}

class UpdateName extends EditAccountEvent {
  final String name;
  UpdateName(this.name);
}

class UpdateLastName extends EditAccountEvent {
  final String lastname;
  UpdateLastName(this.lastname);
}

class UpdateCellphone extends EditAccountEvent {
  final String cellphone;
  UpdateCellphone(this.cellphone);
}

class UpdateEmail extends EditAccountEvent {
  final String email;
  UpdateEmail(this.email);
}
